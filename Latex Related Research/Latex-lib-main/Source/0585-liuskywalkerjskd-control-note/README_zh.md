# 控制理论实用指南

[English README](./README.md)

---

## 这是什么？

这是一个面向真实机器人工程实践的控制理论笔记仓库。
核心目标是：帮助你在真实硬件上设计、调参、排查控制器问题。

内容编排始终围绕一个问题展开：  
**“机器人真正上场时，这个理论到底有什么用？”**

## 写给谁看？

主要面向大一到大三本科生，前置知识是基础微积分和线性代数。  
只要你能理解导数和矩阵乘法，就可以开始。

## 目录

### 第一部分：基础
| # | 章节 | 主要内容 |
|---|------|----------|
| - | **两个支配世界的数：$e$ 与 $\pi$** | $\pi$ 主导周期性，$e$ 主导衰减；欧拉公式 |
| 1 | **引言** | 写作动机、学习路径、阅读方式 |

### 第二部分：理论主线
| # | 章节 | 主要内容 |
|---|------|----------|
| 2 | **数字信号处理** | 拉普拉斯/傅里叶/Z 变换、极零点、低通/带通/高通/陷波滤波 |
| 3 | **系统描述** | 传递函数、状态空间、稳定性、二阶系统、电机建模 |
| 4 | **经典控制** | Bode 图、PID（单环/串级/并联）、正反馈诊断、调参、前馈、系统辨识 |
| 5 | **离散化与实现** | ZOH、Tustin、FIR/IIR 设计、定点数、嵌入式实现 |
| 6 | **现代控制** | LQR（+ PID 的状态空间本质）、MPC、NMPC、TinyMPC、卡尔曼/EKF、LQG、轨迹规划 |
| 7 | **非线性控制** | 反馈线性化、滑模控制、增益调度、Lyapunov 设计、NMPC 对比 |

### 第三部分：实践
| # | 章节 | 主要内容 |
|---|------|----------|
| 8 | **多环架构设计** | 完整控制栈、串级架构、带宽分离、状态机、RTOS |
| 9 | **调试与调参手册** | 诊断流程图、故障模式特征、真实硬件 PID 调参 |

### 第四部分：前沿与参考
| # | 章节 | 主要内容 |
|---|------|----------|
| 10 | **展望** | 数据驱动控制、Koopman、自适应控制、RL、扩散策略、VLA、Neural ODE |
| 附A | **附录：C++ 模块** | 仅头文件、嵌入式友好的算法模块 |
| 附B | **附录：姿态与旋转** | 坐标系（NWU）、旋转矩阵、欧拉角、万向锁、四元数 |

## 内容结构

理论部分一气呵成（从 DSP 到非线性控制），实践章节集中在架构和调试，最后是前沿展望和参考附录。

## 项目结构

```text
Control-Note/
├─ main.tex                  # 英文主文档
├─ main_zh.tex               # 中文主文档
├─ sections_zh/              # 中文分章节源码
├─ include/                  # 共享 include 资源
├─ figures/                  # 英文图表
├─ figures_zh/               # 中文图表
├─ scripts/                  # 图表生成脚本
├─ build/                    # 编译输出 PDF
├─ README.md                 # 英文 README
└─ README_zh.md              # 中文 README
```

## 如何编译

### Overleaf

直接导入仓库，并使用 **XeLaTeX** 编译。

### 本地编译（推荐）

项目提供了编译脚本，前置步骤如下：

1. **安装 TeX Live**（用户空间安装，无需 sudo）：
   ```bash
   # 下载安装器
   cd /tmp && wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
   tar xzf install-tl-unx.tar.gz && cd install-tl-*/

   # 运行安装器（选择 "small" 方案以节省空间）
   perl install-tl

   # 安装完成后，将 TeX Live 添加到 PATH（根据实际年份调整）
   echo 'export PATH="$HOME/texlive/2026/bin/x86_64-linux:$PATH"' >> ~/.bashrc
   source ~/.bashrc

   # 安装项目所需的 LaTeX 包
   tlmgr install latexmk ctex mdframed zref needspace booktabs enumitem float caption
   ```

2. **使用脚本编译 PDF**：
   ```bash
   # 编译中英文双版本
   ./scripts/build.sh all

   # 仅编译英文版
   ./scripts/build.sh en

   # 仅编译中文版
   ./scripts/build.sh zh

   # 清理辅助文件
   ./scripts/build.sh clean
   ```

   输出文件：
   - `build/Control_Theory_Note.pdf`（英文版）
   - `build/Control_Theory_Note_cn.pdf`（中文版）

### 手动编译

如果你不想使用脚本，也可以直接运行：

```bash
# 英文版（pdflatex）
latexmk -pdf -interaction=nonstopmode main.tex

# 中文版（xelatex）
latexmk -xelatex -interaction=nonstopmode main_zh.tex
```

## 重新生成图表

```bash
pip install matplotlib numpy
python scripts/generate_figures_zh.py
python scripts/generate_advanced_figures_zh.py
```

完整脚本列表请查看 `scripts/` 目录。

## 参与贡献

欢迎通过 Issue 或 Pull Request 提交错别字修正、技术勘误和结构优化建议。
