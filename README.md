# Quero Ser MB – Desafio iOS

Este projeto é uma resposta ao desafio técnico proposto pela equipe do Mercado Bitcoin.

## 📱 Descrição

A aplicação consome dados do endpoint [https://rest.coinapi.io/v1/exchanges](https://docs.coinapi.io/market-data/rest-api/metadata/list-all-exchanges) e exibe uma lista de exchanges, com detalhes como nome, volumes e website. A interface foi construída utilizando UIKit e como arquitetura VIPER.

## 📂 Estrutura do Projeto

```
MercadoBitcoinExercise/
├── AppDelegate.swift
├── SceneDelegate.swift
│
├── View/
│   ├── ExchangeListViewController.swift
│   ├── ExchangeDetailViewController.swift
│   ├── ExchangeTableViewCell.swift
│   └── ErrorView.swift
│
├── Presenter/
│   ├── ExchangePresenter.swift
│   ├── ExchangeViewModel.swift
│   └── ExchangeViewModelMapper.swift
│
├── Interactor/
│   ├── ExchangeInteractor.swift
│   ├── Exchange.swift
│   └── ExchangeMapper.swift
│
├── Service/
│   ├── ExchangeService.swift
│   ├── ExchangeResponse.swift
│   └── URLSessionProtocol.swift
│
├── Router/
│   └── ExchangeRouter.swift
│
└── Config/
    ├── Config.plist
    └── ConfigurationManager.swift
```

## ✅ Funcionalidades básicas
- Arquitetura
- Testes
- Tratamento de erro
- Cache
- UI/UX

### ⏭️ O que pode melhorar
- Incluir labels para garantir a acessibilidade
- Incluir tracking
- Refreshing: os dados são atualizados pelo usuário (pull to refresh). Esta funcionalidade pode ser melhorada ao incluir um refresh automático a cada X minutos.
- UI/UX: incluir na tela principal a informação de quando o dado foi atualizado pela última vez
- UI/UX: incluir a funcionalidade de busca
- Tratamento de erro: caso ocorra um erro ao tentar atualizar os dados, ao invés de mostrar a tela de erro, poderia mostrar a lista desatualizada dos dados, com algum indicativo de quando foi a última atualização.
- Seguraça: gerenciar a API key de forma mais segura


## 🧪 Considerações sobre testes

### Snapshot tests
Este projeto utiliza a biblioteca [SnapshotTesting](https://github.com/pointfreeco/swift-snapshot-testing) da Point-Free para validar visualmente componentes de interface. Os testes garantem que a lista de exchanges e a tela de erro mantenham sua aparência conforme o esperado ao longo do tempo.

## ⚠️ Limitações da API
Inicialmente, ao tentar pegar os dados do endpoiment mencionado acima, eu estava recebendo como resposta 429 (Too Many Requests). Para o conseguir acessar o endpoint, eu tive que colocar créditos na minha conta da coinAPI. 

# 🙋‍♀️ Sobre Mim
Desenvolvedora iOS com 4+ anos de experiência, atuando principalmente no setor financeiro. Estou entusiasmada com a oportunidade de contribuir com o time do Mercado Bitcoin. Obrigada pelo tempo dedicado na revisão desse projeto e espero que possamos conversar sobre ele em breve.
