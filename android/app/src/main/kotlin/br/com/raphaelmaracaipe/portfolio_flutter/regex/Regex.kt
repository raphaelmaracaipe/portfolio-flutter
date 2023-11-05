package br.com.raphaelmaracaipe.portfolio_flutter.regex

import com.github.curiousoddman.rgxgen.RgxGen

class Regex {

    fun generate(pattern: String) = (RgxGen(pattern).generate() ?: "")

}