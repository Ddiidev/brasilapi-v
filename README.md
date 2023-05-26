<div align="center">
<h1>
<img src="https://raw.githubusercontent.com/BrasilAPI/BrasilAPI/main/public/brasilapi-logo-small.png" />

<div>

</div>
</h1>


</div>

Uma [lib](https://vpm.vlang.io/mod/ldedev.brasilapi) para a API do [BrasilAPI](https://github.com/BrasilAPI/BrasilAPI) (para o [V](https://vlang.io/))

### É possível encontrar toda a documentação desse client/sdk na [doc](https://ldedev.github.io/brasilapi-v/).

<br/>

# Features

- [X] **CEP (Zip code)**
- [X] **DDD**
- [X] **Bank**
- [X] **Corretoras**
- [X] **CNPJ**
- [X] **Feriados Nacionais**
- [X] **Registros de domínios br**
- [X] **IBGE**
- [X] **Tabela FIPE**
- [X] **ISBN**
- [X] **Taxas**
- [X] **PIX**
- [X] **NCM**
- [X] **CPTEC**

# Como contribuir

Veja [CONTRIBUTING.md](./CONTRIBUTING.md) para ver como contribuir com o projeto.

# Instalação

`v install ldedev.brasilapi`

<br/><br/>

# Como usar

```v
import ldedev.brasilapi.cep.v1 as cep

fn main() {
	if cep_ := cep.get_cep('63900-193') {
	    dump(cep_)
	} else {
	    // print message error
	    println(err)
	}
}
```

Resultado:
```
[.\\src\\main.v:7] cep_: v1.Cep{
    cep: '63900193'
    state: 'CE'
    city: 'Quixadá'
    neighborhood: 'Centro'
    street: 'Rua Doutor Rui Maia'
    service: 'correios'
}
```

<br/><br/>

## Capturando detalhes de erros
```v
import ldedev.brasilapi.cep.v2 as cep
import ldedev.brasilapi.cep.errors

fn main() {
	if cep_ := cep.get_cep('00000-000') {
    	dump(cep_)
	} else {
	    if err is errors.CepError {
            dump(err)
        }
	}
}
```

Resultado:
```
[.\\src\\main.v:9] err: &errors.CepError{
    Error: Error{}
    message: 'Todos os serviços de CEP retornaram erro.'
    type: 'service_error'
    name: 'CepPromiseError'
    errors: [struct {
        name: 'ServiceError'
        message: 'CEP INVÁLIDO'
        service: 'correios'
    }, struct {
        name: 'ServiceError'
        message: 'Erro ao se conectar com o serviço ViaCEP.'
        service: 'viacep'
    }, struct {
        name: 'ServiceError'
        message: 'Erro ao se conectar com o serviço WideNet.'
        service: 'widenet'
    }, struct {
        name: 'ServiceError'
        message: 'CEP não encontrado na base dos Correios.'
        service: 'correios-alt'
    }]
}
```

Ou pode simplesmente usar `err.msg()`, isso vale pra todos os módulos.


# Autor

<div align="center">


| [<img width="80" height="80" src="https://avatars.githubusercontent.com/u/7676415?v=4?size=32" width=115><br><sub>@ldedev</sub>](https://github.com/ldedev) |
| :-----------------------------------------------------------------------------------------------------------------------------------------------------------: |

</div>

# License

[MIT](./LICENSE)
