<!doctype html>
<html lang="en" class="h-100">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <title>Inventory Soft</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/5.1/examples/cover/">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
    </style>

  </head>
  <body class="d-flex h-100 text-center text-white bg-dark">
    
<div class="cover-container d-flex w-100 h-100 p-3 mx-auto flex-column">
  <header class="mb-auto">
    <div>
      <h3 class="float-md-start mb-0">Inventory Soft</h3>
      <nav class="nav nav-masthead justify-content-center float-md-end">
        <a class="nav-link active" aria-current="page" href="#">
            @if (Route::has('login'))
                    @if (Auth::check())
                        <a href="{{ action('HomeController@index') }}">@lang('home.home')</a>
                    @else
                        <a class="nav-link" href="{{ action('Auth\LoginController@login') }}">@lang('lang_v1.login')</a>
                        @if(env('ALLOW_REGISTRATION', true))
                            <a class="nav-link" href="{{ route('business.getRegister') }}">@lang('lang_v1.register')</a>
                        @endif
                    @endif
                
        </a>
        @endif

        @if(Route::has('pricing') && config('app.env') != 'demo')
            <a href="{{ action('\Modules\Superadmin\Http\Controllers\PricingController@index') }}">@lang('superadmin::lang.pricing')</a>
        @endif
        
      </nav>
    </div>
  </header>

  <main class="px-3">
    <img src="{{asset('img/logo-sin-fondo.png')}}">

    <h1>Inventory Soft</h1>
  </main>

  <footer class="mt-auto text-white-50">
    <p>Ing. Chehin Juan Martin, por <a href="https://juanchehin.github.io/slider/" class="text-white">Slider Tucuman</a>.</p>
  </footer>
</div>


    
  </body>
</html>
