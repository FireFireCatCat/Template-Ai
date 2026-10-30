"""Generate positive-feedback vs correct PID comparison figure."""

import numpy as np
import matplotlib.pyplot as plt

STRINGS = {
    'en': {
        'title': 'Correct PID vs Sign-Error PID (Positive Feedback)',
        'correct': 'Correct: negative feedback',
        'wrong': 'Wrong: positive feedback (sign error)',
        'setpoint': 'Setpoint',
        'xlabel': 'Time (s)',
        'ylabel_pos': 'Position',
        'ylabel_ctrl': 'Control signal',
        'ctrl_title': 'Control Output — Positive Feedback Saturates Instantly',
        'annotation': 'System runs away\nto actuator limit',
        'limit': 'Actuator saturation',
    },
    'zh': {
        'title': '正确 PID vs 符号错误 PID（正反馈）',
        'correct': '正确：负反馈',
        'wrong': '错误：正反馈（符号反了）',
        'setpoint': '设定值',
        'xlabel': '时间 (s)',
        'ylabel_pos': '位置',
        'ylabel_ctrl': '控制信号',
        'ctrl_title': '控制输出——正反馈瞬间饱和',
        'annotation': '系统飞车\n直冲执行器极限',
        'limit': '执行器饱和',
    },
}


def plot_positive_feedback(outpath, lang='en'):
    S = STRINGS[lang]

    if lang == 'zh':
        plt.rcParams.update({
            'font.family': 'sans-serif',
            'font.sans-serif': ['Noto Sans SC', 'DejaVu Sans'],
            'axes.unicode_minus': False,
            'font.size': 10,
        })
    else:
        plt.rcParams.update({'font.family': 'serif', 'font.size': 10})

    dt = 0.001
    t = np.arange(0, 1.5, dt)
    setpoint = np.where(t >= 0.1, 90.0, 0.0)

    J = 0.05
    friction = 0.5
    kp, ki, kd = 6.0, 0.3, 3.0
    u_max = 5000

    def sim_pid(sign=1.0):
        """sign=1 for correct, sign=-1 for positive feedback"""
        pos = 0.0
        vel = 0.0
        integral = 0.0
        prev_meas = 0.0
        positions = []
        outputs = []
        for i in range(len(t)):
            meas = pos
            e = sign * (setpoint[i] - meas)  # sign error here
            integral += ki * e * dt
            integral = np.clip(integral, -u_max, u_max)
            d = -kd * (meas - prev_meas) / dt if i > 0 else 0.0
            out = kp * e + integral + d
            out = np.clip(out, -u_max, u_max)

            acc = (out - friction * vel) / J
            vel += acc * dt
            pos += vel * dt
            prev_meas = meas
            positions.append(pos)
            outputs.append(out)
        return np.array(positions), np.array(outputs)

    y_correct, u_correct = sim_pid(sign=1.0)
    y_wrong, u_wrong = sim_pid(sign=-1.0)

    fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(9, 5.5), sharex=True)

    # Top: position
    ax1.plot(t, setpoint, 'k--', linewidth=1, label=S['setpoint'])
    ax1.plot(t, y_correct, 'C0', linewidth=2, label=S['correct'])
    ax1.plot(t, y_wrong, 'C3', linewidth=2, label=S['wrong'])
    ax1.set_ylabel(S['ylabel_pos'])
    ax1.set_title(S['title'], fontsize=12)
    ax1.legend(fontsize=9, loc='center right')
    ax1.set_ylim(-500, 500)
    ax1.axhline(0, color='gray', lw=0.3)

    # Annotation on runaway
    idx_annotate = int(0.5 / dt)
    ax1.annotate(S['annotation'],
                 xy=(0.5, y_wrong[idx_annotate]),
                 xytext=(0.8, -350),
                 fontsize=9, color='C3',
                 arrowprops=dict(arrowstyle='->', color='C3', lw=1.2))

    # Bottom: control signal
    ax2.plot(t, u_correct, 'C0', linewidth=1.5, label=S['correct'])
    ax2.plot(t, u_wrong, 'C3', linewidth=1.5, label=S['wrong'])
    ax2.axhline(u_max, color='gray', ls=':', lw=1)
    ax2.axhline(-u_max, color='gray', ls=':', lw=1)
    ax2.text(1.2, u_max + 200, S['limit'], fontsize=8, color='gray', ha='center')
    ax2.text(1.2, -u_max - 400, S['limit'], fontsize=8, color='gray', ha='center')
    ax2.set_xlabel(S['xlabel'])
    ax2.set_ylabel(S['ylabel_ctrl'])
    ax2.set_title(S['ctrl_title'], fontsize=11)
    ax2.legend(fontsize=9)

    fig.tight_layout()
    fig.savefig(outpath, dpi=150, bbox_inches='tight')
    plt.close(fig)
    print(f'  saved {outpath}')


if __name__ == '__main__':
    plot_positive_feedback('figures/positive_feedback_pid.pdf', 'en')
    plot_positive_feedback('figures_zh/positive_feedback_pid.pdf', 'zh')
    print('Done.')
