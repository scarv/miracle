
import operator

from    matplotlib.figure import Figure

def plot_bytes(traces,title):
    
    fig = Figure(figsize=(10,1*len(traces)))
    fig.suptitle(title)
    
    rows = len(traces)
    row  = 1

    for t in sorted(traces, key=operator.attrgetter("name")):
        ax  = fig.add_subplot(rows,1,row)
        ax.set_ylim(0,1.0)
        ax.plot(t.trace,linewidth=0.5)
        row += 1
    
    fig.tight_layout()

    return fig
