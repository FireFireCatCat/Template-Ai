/**
 * Plug-in ways through the app's own compile path. The app compiles a paper on
 * General with a constructed template's plug-ins and looks (Flouest ADR-351),
 * found by name in the template registry (`compileTemplateFor`). There is no
 * other door for plug-ins into `docJsonToLatex`. So a set of plug-in ways is
 * registered, for this process only, as a template of its own: General's class
 * and preamble, no looks of its own, no kinds of its own, and the plug-ins.
 * Nothing is written to the checkout.
 *
 * Each plug-in replaces a node's handler with General's plus the styles its
 * ways add, so a node no way binds prints exactly as in General. That is what
 * lets a new way leave every old document's LaTeX as it was, and the
 * dummy-way check holds the binding to it.
 *
 * The template's name is a hash of the plug-ins' code, since the registry
 * keeps what it built under the name.
 */
import { defaultProfile } from '@flouest/JSON->Latex Compiler/src/Profile/Profile_General/index.ts';
import type { HandlerPlugin } from '@flouest/JSON->Latex Compiler/src/Plugins/plugins.ts';
import type { TemplateBundle } from '@flouest/Template/template-pipeline-journal/bundle.ts';
import { TEMPLATE_BUNDLES } from '@flouest/Template/template-pipeline-journal/bundles.ts';
import type { TemplateCall } from '@flouest/Template/template-pipeline-journal/define.ts';
import { TEMPLATE_CALLERS } from '@flouest/Template/templates/index.ts';
import { hashJson } from 'compat-core';

import type { WayPlugin } from './ways.ts';

/**
 * General's class line and the lines after it (`DOCUMENT_DECLARATION` in the
 * app's `lib/latex.ts`, which it does not export). The host checks every
 * General document starts with them, so a change there is caught, not copied
 * wrong.
 */
export const GENERAL_DECLARATION = [
  '\\documentclass{article}',
  '\\usepackage{lmodern}',
  '\\usepackage{fontspec}',
  '\\setmainfont{Latin Modern Roman}[SmallCapsFont={Latin Modern Roman Caps}]',
  '\\setsansfont{Latin Modern Sans}',
  '\\setmonofont{Inconsolatazi4-Regular.otf}[BoldFont=Inconsolatazi4-Bold.otf]',
  '\\usepackage{amsmath}',
  '\\usepackage{amssymb}',
  '\\usepackage{mathtools}',
] as const;

/** The plug-ins for these ways: one per node handler, General's styles and each way's own. */
export const handlerPlugins = (plugins: readonly WayPlugin[]): HandlerPlugin[] => {
  const byHandler = new Map<string, WayPlugin[]>();
  for (const p of plugins) byHandler.set(`${p.family}/${p.kind}`, [...(byHandler.get(`${p.family}/${p.kind}`) ?? []), p]);
  return [...byHandler.values()].map((ways) => {
    const [{ family, kind }] = ways as [WayPlugin, ...WayPlugin[]];
    const general = defaultProfile[family][kind];
    if (general === undefined) throw new Error(`plug-in: General has no handler ${family}/${kind} to add a style to`);
    for (const w of ways) if (w.style in general) throw new Error(`plug-in: ${family}/${kind} already has a style "${w.style}" in General`);
    return { family, kind, handler: { ...general, ...Object.fromEntries(ways.map((w) => [w.style, w.realization])) } };
  });
};

/** Registers the plug-ins as a template for this process, and returns its name; General's, with none. */
export const pluginTemplate = (plugins: readonly WayPlugin[]): string | undefined => {
  if (plugins.length === 0) return undefined;
  const handlers = handlerPlugins(plugins);
  const name = `compat-${hashJson(plugins.map((p) => ({ family: p.family, kind: p.kind, style: p.style, preamble: String(p.realization.preamble), emit: String(p.realization.emit) }))).slice(0, 12)}`;
  if (Object.hasOwn(TEMPLATE_BUNDLES, name)) return name;
  const [line, ...preamble] = GENERAL_DECLARATION;
  const bundle = {
    about: 'Registered by the compatibility pipeline for one run: General with plug-in ways.',
    name,
    displayName: name,
    documentClass: { line, preamble },
    kinds: {},
    attrs: {},
    nesting: { changes: {}, own: {} },
    looks: {},
    claims: [],
    protect: [],
    views: {},
    plugins: handlers.map((h) => `${h.family}/${h.kind}`),
  } as unknown as TemplateBundle;
  (TEMPLATE_BUNDLES as Record<string, TemplateBundle>)[name] = bundle;
  (TEMPLATE_CALLERS as Record<string, TemplateCall>)[name] = { name, plugins: handlers } as unknown as TemplateCall;
  return name;
};
