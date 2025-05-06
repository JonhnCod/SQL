##### Definição das variáveis que armazena o publico geral, por categoria e a classificação individual geral e por categoria!

```python 
#Variáveis de publico geral e por categoria
publico_geral = 769
publico_masc = 365
categoria_30anos = 62

# Variáveis de colocação
classificacao_geral = 98
classificacao_categoria30 = 15
classificacao_masc = 79 
```
#### Função que determina a porcentagem da classificação individual em relação ao numero total de corredores que concluíram a prova

```python 
def calcular_porcentagem(metricas_individual,metricas_geral):

    porcentagem = (metricas_individual / metricas_geral)

    return f'{porcentagem:.2%}'
```
#### Função principal que exibe na tela, texto formatado mostrando resultados de desempenho na prova

```python
def main():

    print('Aqui está a estatística de sua ultima Prova de 5km! (obs: Os numeros gerais foram de corredores que terminaram a prova)\n')

    print(f'Público geral: No público geral teve {publico_geral} corredores e sua colocaçao foi {classificacao_geral}º lugar, o que siginifica que você está entre os {calcular_porcentagem(classificacao_geral,publico_geral)} de competidores mais veloz nessa prova\n')

    print(f'Categoria masculino: Na categoria masculino teve um total de {publico_masc} corredores, e sua posição foi {classificacao_masc}º, esse resultado te coloca entre os {calcular_porcentagem(classificacao_masc,publico_masc) mais veloz nessa categoria!\n')

    print(f'Categoria 30 a 34 anos: Na categoria de 30 a 34 anos teve um público de {categoria_30anos} corredores e sua classificação foi {classificacao_categoria30}, o que representa {calcular_porcentagem(classificacao_categoria30,categoria_30anos)} do total dessa categoria que teve melhor desempenho\n')
 
    print(f'Em resumo você teve um excelente desempenho com um tempo total de 00:24:52 min, pace médio de 04:52 por KM, superando 87.25% dos corredores em geral!!')
```
#### Essa condição garante que a função 'main()', seja de uso exclusivo para esse Script!

```python
if __name__ == "__main__":

    main()
```


