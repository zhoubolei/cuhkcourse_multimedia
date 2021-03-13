import numpy as np
from matplotlib import pyplot as plt
import os


def quantize_uniform(x, quant_min=-1, quant_max=1, quant_level=5):
    """Uniform quantization approach

    Notebook: C2S2_DigitalSignalQuantization.ipynb

    Args:
        x: Original signal
        quant_min: Minimum quantization level
        quant_max: Maximum quantization level
        quant_level: Number of quantization levels

    Returns:
        x_quant: Quantized signal
    """
    x_normalize = (x-quant_min) * (quant_level-1) / (quant_max-quant_min)                       # The signal is normlized to the [0, quant_level-1]
    x_normalize[x_normalize > quant_level - 1] = quant_level - 1                                # Overwrite the values out of range
    x_normalize[x_normalize < 0] = 0                                                            # Overwrite the values out of range
    x_normalize_quant = np.around(x_normalize)                                                  # Truncate the signal to the given quantized levels
    x_quant = (x_normalize_quant) * (quant_max-quant_min) / (quant_level-1) + quant_min         # Denormalized to the original 
    return x_quant

def plot_graph_quant_function(ax, quant_min=-1, quant_max=1, quant_level=256, mu='255', quant='uniform'):
    """Helper function for plotting a graph of quantization function and quantization error
    Notebook: C2S2_DigitalSignalQuantization.ipynb
    """
    x = np.linspace(quant_min, quant_max, 1000)
    x_quant = quantize_uniform(x, quant_min=quant_min, quant_max=quant_max, quant_level=quant_level)
    quant_stepsize = (quant_max - quant_min) / (quant_level-1)
    title = r'$\lambda = %d, \Delta=%0.2f$' % (quant_level, quant_stepsize)
    error = np.abs(x_quant - x)
    ax.plot(x, x, color='k', label='Original amplitude')
    ax.plot(x, x_quant, color='b', label='Quantized amplitude')
    ax.plot(x, error, 'r--', label='Quantization error')
    ax.set_title(title)
    ax.set_xlabel('Amplitude')
    ax.set_ylabel('Quantized amplitude/error')
    ax.set_xlim([quant_min, quant_max])
    ax.set_ylim([quant_min, quant_max])
    ax.grid('on')
    ax.legend()

def plot_signal_quant(x, t, x_quant, figsize=(8, 2), xlim=None, ylim=None, title=''):
    """Helper function for plotting a signal and its quantized version
    Notebook: C2S2_DigitalSignalQuantization.ipynb
    """    
    plt.figure(figsize=figsize)
    plt.plot(t, x, color='gray', linewidth=1.0, linestyle='-', label='Original signal')
    plt.plot(t, x_quant, color='red', linewidth=2.0, linestyle='-', label='Quantized signal')
    if xlim is None:
        plt.xlim([0, t[-1]])
    else:
        plt.xlim(xlim)
    if ylim is not None:
        plt.ylim(ylim)
    plt.xlabel('Time (seconds)')
    plt.ylabel('Amplitude')
    plt.title(title)
    plt.legend(loc='upper right', framealpha=1)
    plt.tight_layout()
    plt.show()
    
# plt.figure(figsize=(12,4))
# ax = plt.subplot(1, 3, 1)
# plot_graph_quant_function(ax, quant_min=-1, quant_max=4, quant_level=3)
# ax = plt.subplot(1, 3, 2)
# plot_graph_quant_function(ax, quant_min=-2, quant_max=2, quant_level=4)
# ax = plt.subplot(1, 3, 3)
# plot_graph_quant_function(ax, quant_min=-1, quant_max=1, quant_level=9)
# plt.tight_layout()
# plt.show()


def quantize(x, quant_min=-1, quant_max=1, quant_level=5):
    """Uniform quantization approach

    Notebook: C2S2_DigitalSignalQuantization.ipynb

    Args:
        x: Original signal
        quant_min: Minimum quantization level
        quant_max: Maximum quantization level
        quant_level: Number of quantization levels

    Returns:
        x_quant: Quantized signal
    """
    x_normalize = (x-quant_min) * (quant_level-1) / (quant_max-quant_min)                       # The signal is normlized to the [0, quant_level-1]
    x_normalize[x_normalize > quant_level - 1] = quant_level - 1                                # Overwrite the values out of range
    x_normalize[x_normalize < 0] = 0                                                            # Overwrite the values out of range
    import pdb
    pdb.set_trace()
    x_normalize_quant = np.ceil(x_normalize + 0.5)                                                  # Truncate the signal to the given quantized levels
    x_quant = (x_normalize_quant) * (quant_max-quant_min) / (quant_level-1) + quant_min         # Denormalized to the original 
    return x_quant

import math
start = -8
end = 8
t = np.linspace(start, end, 1000)
x = 8 * np.sin(t * math.pi / 4 + math.pi / 2)

quant_min = -8
quant_max = 8
quant_level = 16
x_quant = quantize(x, quant_min=quant_min, quant_max=quant_max, 
                          quant_level=quant_level)
plot_signal_quant(x, t, x_quant, xlim=[start, end], ylim=[-10,10], 
                  title=r'Uniform quantization with min=$%0.1f$, max=$%0.1f$, $\lambda$=$%d$'%(quant_min, quant_max, quant_level));
