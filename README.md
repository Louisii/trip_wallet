# trip_wallet

### Se a moeda de entrada for "BR$":

O valor em Real Brasileiro (valorBR) é definido como o valorDeEntrada (pois já está em reais).
O valor em Dólar Americano (valorUS) é calculado dividindo o valorDeEntrada pela cotação do dólar americano (cotacaoUS).
O valor em Dólar Canadense (valorCAD) é calculado dividindo o valorDeEntrada pela cotação do dólar canadense (cotacaoCAD).

### Se a moeda de entrada for "US$":

O valor em Real Brasileiro (valorBR) é calculado multiplicando o valorDeEntrada pela cotação do dólar americano (cotacaoUS) e aplicando a taxa de conversão (taxaUS) e o IOF.
O valor em Dólar Americano (valorUS) é definido como o valorDeEntrada (pois já está em dólares americanos).
O valor em Dólar Canadense (valorCAD) é calculado dividindo o valorDeEntrada pelo valor em Dólar Americano (valorUS) e multiplicando pela cotação do dólar canadense (cotacaoCAD).

### Se a moeda de entrada for "CAD$":

O valor em Real Brasileiro (valorBR) é calculado multiplicando o valorDeEntrada pela cotação do dólar canadense (cotacaoCAD) e aplicando a taxa de conversão (taxaCAD) e o IOF.
O valor em Dólar Canadense (valorCAD) é definido como o valorDeEntrada (pois já está em dólares canadenses).
O valor em Dólar Americano (valorUS) é calculado dividindo o valorDeEntrada pelo valor em Dólar Canadense (valorCAD) e multiplicando pela cotação do dólar americano (cotacaoUS).
