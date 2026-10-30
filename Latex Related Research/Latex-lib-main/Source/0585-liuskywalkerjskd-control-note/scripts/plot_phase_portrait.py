"""Generate phase portrait of inverted pendulum for nonlinear control chapter."""

import numpy as np
import matplotlib.pyplot as plt

STRINGS = {
    'en': {
        'title': 'Phase Portrait of Inverted Pendulum (unforced)',
        'xlabel': r'Angle $\theta$ (rad)',
        'ylabel': r'Angular velocity $\dot{\theta}$ (rad/s)',
        'upright': 'Upright\n(unstable)',
        'hanging': 'Hanging\n(stable)',
        'separatrix': 'Separatrix',
        'linear_region': 'Linear region\n(LQR works here)',
        'nonlinear': 'Nonlinear region\n(need swing-up)',
    },
    'zh': {
        'title': '倒立摆相图（无外力）',
        'xlabel': r'角度 $\theta$（rad）',
        'ylabel': r'角速度 $\dot{\theta}$（rad/s）',
        'upright': '竖直向上\n（不稳定）',
        'hanging': '竖直向下\n（稳定）',
        'separatrix': '分离线',
        'linear_region': '线性区域\n（LQR 可用）',
        'nonlinear': '非线性区域\n（需要摆起控制）',
    },
}


def plot_phase_portrait(outpath, lang='en'):
    S = STRINGS[lang]

    if lang == 'zh':
        plt.rcParams.update({
            'font.family': 'sans-serif',
            'font.sans-serif': ['Noto Sans SC', 'DejaVu Sans'],
            'axes.unicode_minus': False,
        })
    else:
        plt.rcParams.update({'font.family': 'serif'})

    fig, ax = plt.subplots(figsize=(9, 5.5))

    # Pendulum dynamics: theta_dd = (g/l)*sin(theta) - b*theta_d
    # (using hanging-down convention: theta=0 is down, theta=pi is up)
    g_over_l = 9.81
    damping = 0.3

    # Create grid
    theta = np.linspace(-1.5 * np.pi, 2.5 * np.pi, 400)
    theta_dot = np.linspace(-8, 8, 300)
    TH, THD = np.meshgrid(theta, theta_dot)

    # Dynamics
    dTH = THD
    dTHD = g_over_l * np.sin(TH) - damping * THD  # theta=0 is hanging (stable)

    # Speed for color
    speed = np.sqrt(dTH**2 + dTHD**2)

    # Streamplot
    ax.streamplot(TH, THD, dTH, dTHD, color=speed, cmap='coolwarm',
                  density=1.8, linewidth=0.6, arrowsize=0.8, arrowstyle='->')

    # Mark equilibria
    # Hanging (stable): theta = 0, 2*pi
    for th_eq in [0, 2*np.pi]:
        ax.plot(th_eq, 0, 'go', markersize=10, zorder=5, markeredgecolor='k', markeredgewidth=1)
    ax.text(0, -1.2, S['hanging'], ha='center', fontsize=9, color='green',
            fontweight='bold')

    # Upright (unstable): theta = pi
    ax.plot(np.pi, 0, 'rs', markersize=10, zorder=5, markeredgecolor='k', markeredgewidth=1)
    ax.text(np.pi, -1.2, S['upright'], ha='center', fontsize=9, color='red',
            fontweight='bold')

    # Draw separatrices (energy level curves for the conservative system)
    # E = 0.5 * theta_dot^2 - g/l * cos(theta)
    # Separatrix passes through (pi, 0): E_sep = g/l
    theta_fine = np.linspace(-1.5*np.pi, 2.5*np.pi, 1000)
    E_sep = g_over_l  # energy at the saddle
    # theta_dot = +-sqrt(2*(E_sep + g/l*cos(theta)))
    inside = 2 * (E_sep + g_over_l * np.cos(theta_fine))
    mask = inside >= 0
    td_sep = np.sqrt(np.where(mask, inside, 0))

    ax.plot(theta_fine[mask], td_sep[mask], 'k--', linewidth=2, alpha=0.7,
            label=S['separatrix'])
    ax.plot(theta_fine[mask], -td_sep[mask], 'k--', linewidth=2, alpha=0.7)

    # Shade the linearization region around theta=pi
    from matplotlib.patches import FancyBboxPatch, Circle
    linear_half = 0.3  # ~17 degrees
    rect = plt.Rectangle((np.pi - linear_half, -2.5), 2*linear_half, 5,
                          facecolor='C0', alpha=0.12, edgecolor='C0',
                          linewidth=1.5, linestyle='-', zorder=2)
    ax.add_patch(rect)
    ax.annotate(S['linear_region'],
                xy=(np.pi, 2.0), xytext=(np.pi + 1.5, 5.5),
                fontsize=9, color='C0', fontweight='bold',
                arrowprops=dict(arrowstyle='->', color='C0', lw=1.2),
                ha='center')

    # Label nonlinear region
    ax.text(-0.8, 5.5, S['nonlinear'], fontsize=9, color='C3',
            fontweight='bold', ha='center')

    # Axis labels
    ax.set_xlabel(S['xlabel'], fontsize=11)
    ax.set_ylabel(S['ylabel'], fontsize=11)
    ax.set_title(S['title'], fontsize=12)

    # Custom x-ticks
    ax.set_xticks([0, np.pi/2, np.pi, 3*np.pi/2, 2*np.pi])
    ax.set_xticklabels([r'$0$', r'$\pi/2$', r'$\pi$', r'$3\pi/2$', r'$2\pi$'])

    ax.set_xlim(-0.5*np.pi, 2.5*np.pi)
    ax.set_ylim(-8, 8)
    ax.legend(loc='lower right', fontsize=9)

    fig.tight_layout()
    fig.savefig(outpath, dpi=150, bbox_inches='tight')
    plt.close(fig)
    print(f'  saved {outpath}')


if __name__ == '__main__':
    plot_phase_portrait('figures/phase_portrait_pendulum.pdf', 'en')
    plot_phase_portrait('figures_zh/phase_portrait_pendulum.pdf', 'zh')
    print('Done.')
