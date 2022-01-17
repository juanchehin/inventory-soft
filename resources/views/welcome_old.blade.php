<!doctype html>
<html lang="{{ config('app.locale') }}">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        {{--  <title>{{ config('app.name', 'InventorySoft') }}</title>  --}}
        <title>Inventory Soft</title>
        

        <!-- Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Raleway:100,300,600" rel="stylesheet" type="text/css">

        <!-- Styles -->
        <style>
            html, body {
                background-color: #8290e4;
                color: #000000;
                font-family: 'Roboto Mono', sans-serif;
                font-weight: 100;
                height: 100vh;
                margin: 0;

            }

            .full-height {
                height: 100vh;
            }

            .flex-center {
                align-items: center;
                display: flex;
                justify-content: center;
            }

            .position-ref {
                position: relative;
            }

            .top-right {
                position: absolute;
                right: 10px;
                top: 18px;
            }

            .content {
                text-align: center;
            }

            .title {
                font-size: 84px;
            }

            .links > a {
                color: #636b6f;
                padding: 0 25px;
                font-size: 12px;
                font-weight: 600;
                letter-spacing: .1rem;
                text-decoration: none;
                text-transform: uppercase;
            }

            .m-b-md {
                margin-bottom: 30px;
            }

            .tagline{
                font-size:25px;
                font-weight: 300;
            }
        </style>
    </head>
    <body>
        <div class="flex-center position-ref full-height">
            <div class="top-right links">

                @if (Route::has('login'))
                    @if (Auth::check())
                        <a href="{{ action('HomeController@index') }}">@lang('home.home')</a>
                    @else
                        <a href="{{ action('Auth\LoginController@login') }}">@lang('lang_v1.login')</a>
                        @if(env('ALLOW_REGISTRATION', true))
                            <a href="{{ route('business.getRegister') }}">@lang('lang_v1.register')</a>
                        @endif
                    @endif
                @endif

                @if(Route::has('pricing') && config('app.env') != 'demo')
                    <a href="{{ action('\Modules\Superadmin\Http\Controllers\PricingController@index') }}">@lang('superadmin::lang.pricing')</a>
                @endif
            </div>

            <div class="content">
                <img src="https://i.pinimg.com/564x/1e/2c/4b/1e2c4b6bf2cfb29ff933e59d3d8ba92d.jpg">
                {{--  <div class="title m-b-md" style="font-weight: 600 !important">
                    {{ config('app.name', 'InventorySoft') }}
                </div>  --}}
                <div class="title m-b-md" style="font-weight: 600 !important">
                    Inventory Soft
                </div>                
                <p class="tagline">
                    {{ env('APP_TITLE', '') }}
                </p>
            </div>
        </div>
    </body>
</html>
