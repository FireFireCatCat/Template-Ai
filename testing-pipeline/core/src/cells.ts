/**
 * A filed document's cells (ARCHITECTURE.md section 5): its branches built by
 * the host with the probes recorded (`Host.build`), packed in the order filed
 * (`Host.pack`), and emitted under each class setting and each setup that
 * applies to it (`Host.emit`), each with what the oracle should expect of
 * every branch.
 *
 * A branch expects the sentinels its host placed. It expects a feature probe
 * when one of its sentinels plays a role in it (`footnote:mark` makes the
 * branch answer the `footnote` probe), so the host declares a feature only by
 * placing for it.
 *
 * A class setting's own files (a class the engine cannot fetch) go with every
 * cell under it, beside the files the host emitted.
 */
import { appliesTo } from './config.ts';
import { cellId } from './ids.ts';
import { FEATURE_PROBES } from './features.ts';
import type { Expected } from './oracle.ts';
import { recordingProbes, SENTINEL_PREAMBLE } from './sentinels.ts';
import type { ClassSetting, Emitted, EngineFile, FiledDocument, Setup } from './model.ts';
import { markedOf } from './plan.ts';
import type { Host } from './ports.ts';
import type { CellJob } from './run.ts';

export type JudgedJob = CellJob & { readonly emitted: Emitted; readonly expected: readonly Expected[] };

export const documentCells = <D, P>(
  host: Host<D, P>,
  document: FiledDocument,
  classSettings: readonly ClassSetting[],
  setups: readonly Setup[],
  classFiles: (setting: ClassSetting) => readonly EngineFile[] = () => [],
): JudgedJob[] => {
  const expected: Expected[] = [];
  const doc = host.pack(
    document.paths.map((branch) => {
      const { probes, placed } = recordingProbes(branch.marked ?? markedOf(branch.id));
      const built = host.build(branch, probes);
      const features = [...new Set(placed.flatMap((s) => (s.role === undefined ? [] : [s.role.split(':')[0] ?? ''])))].filter((f) => f in FEATURE_PROBES);
      expected.push({ branch: branch.id, sentinels: placed, features });
      return built;
    }),
  );
  return classSettings.flatMap((classSetting) =>
    setups
      .filter((setup) => appliesTo(setup, classSetting))
      .map((setup) => {
        const emitted = host.emit(doc, { classSetting, setup, preamble: SENTINEL_PREAMBLE });
        const cell = { id: cellId(document.id, classSetting.id, setup.id), document: document.id, classSetting: classSetting.id, setup: setup.id };
        return { cell, job: { id: cell.id, latex: emitted.latex, files: [...classFiles(classSetting), ...emitted.files] }, emitted, expected };
      }),
  );
};
