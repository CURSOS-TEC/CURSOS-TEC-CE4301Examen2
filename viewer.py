# Este script de python toma como parámetro un archivo de resultados 
# y genera una gráfica con los datos obtenidos. La leyenda del gŕafico es tomado 
# del archivo metadatas.txt. Genera un archivo vectorial con el gráfico generado.

import sys
import getopt
import matplotlib.pyplot as plt



def main(argv):
    try:
        opts, args = getopt.getopt(argv,"hxt:yt:xs:ys:xb:yb:if",["xtitle=","ytitle=","xscale=", "yscale=","xbase=", "ybase=", "inputfolder="]) 
    except getopt.GetoptError:
        print('python3 viewer.py --xtitle <xAxis>  --ytitle <yAxis> --xscale <linear|log> --yscale <linear|log> --xbase <10|2> --ybase <10|2> --inputfolder <./test1/> ')
        sys.exit(2)
    xAxisTitle = 'xAxis'
    yAxisTitle = 'yAxis'
    xScale = 'log'
    xScaleBase = 2
    yScale = 'linear'
    yScaleBase = 10
    resultFile = ""
    svgPlotFile = ""
    for opt, arg in opts:
        #print(opt,arg)
        if opt in ("-xt", "--xtitle"):
            xAxisTitle = arg
        elif opt in ("-yt", "--ytitle"):
            yAxisTitle = arg
        
        elif opt in ("-xs", "--xscale"):
            xScale = arg
        elif opt in ("-ys", "--xbase"):
            xScaleBase = int(arg)
        
        elif opt in ("-xb", "--yscale"):
            yScale = arg
        elif opt in ("-yb", "--ybase"):
            yScaleBase = int(arg)

        elif opt in ("-if", "--inputfolder"):
            resultFile = "{}/plotResult".format(arg)
            resultFileBase = "{}/interchangeBase/plotResult".format(arg)
            resultFileOpt = "{}/interchangeOpt/plotResult".format(arg)
            svgPlotFile = "{}/plotBaseOpt.pdf".format(arg)
        else:
            print('Unknown param')
            sys.exit(1)
        
    # se obtiene el nombre del archivo y demás variables
    x = []
    yBase = []
    yOpt = []
    with open(resultFileBase) as f:
        lines = f.readlines()
        x = lines[0].split(' ') # se obtiene los valores de la primera línea x
        x = list(map(float,x)) 
        yBase = lines[1].split(' ') # se obtiene los valores de la segunda línea y
        yBase = list(map(float,yBase)) 
    with open(resultFileOpt) as f:
        lines = f.readlines() 
        yOpt = lines[1].split(' ') # se obtiene los valores de la segunda línea y
        yOpt = list(map(float,yOpt))
    plt.plot(x, yBase, color="#6c3376", linewidth=3, label='Código Base')  
    plt.plot(x, yOpt, color="#c46d21", linewidth=3, label='Código Optimizado')  
    plt.xlabel(xAxisTitle)  
    plt.ylabel(yAxisTitle)
    #plt.tight_layout()
    plt.title('Cantidad de Ticks [1x10⁹] dada operaciones \n sobre matrices multidimensionales n x n. \n n es la variable independiente')
    plt.legend()
    if(xScale != 'linear' ):
        plt.xscale(xScale, base=int(xScaleBase))
    else:   
        plt.xscale('linear')

    if(yScale != 'linear' ):
        plt.yscale(yScale, base=int(yScaleBase))
    else:   
        plt.yscale('linear') 

    plt.savefig(svgPlotFile)
if __name__ == "__main__":
   main(sys.argv[1:])