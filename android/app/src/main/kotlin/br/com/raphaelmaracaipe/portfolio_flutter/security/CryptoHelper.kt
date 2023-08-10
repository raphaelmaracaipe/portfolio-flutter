package br.com.raphaelmaracaipe.portfolio_flutter.security

import android.util.Base64
import java.security.NoSuchAlgorithmException
import javax.crypto.Cipher
import javax.crypto.NoSuchPaddingException
import javax.crypto.spec.IvParameterSpec
import javax.crypto.spec.SecretKeySpec

class CryptoHelper(
    ivKey: String,
    keyValue: String
) {
    private val ivSpec: IvParameterSpec = IvParameterSpec(ivKey.toByteArray())
    private val keySpec: SecretKeySpec = SecretKeySpec(keyValue.toByteArray(), "AES")
    private var cipher: Cipher? = null

    init {
        try {
            cipher = Cipher.getInstance("AES/CBC/PKCS5Padding")
        } catch (e: NoSuchAlgorithmException) {
            e.printStackTrace()
        } catch (e: NoSuchPaddingException) {
            e.printStackTrace()
        }
    }

    @Throws(Exception::class)
    private fun intArrayToByteArray(intArray: IntArray): ByteArray {
        val byteArray = ByteArray(intArray.size)
        for (i in intArray.indices) {
            val intValue = intArray[i]
            if (intValue < 0 || intValue > 255) {
                throw IllegalArgumentException("Valor do inteiro fora do intervalo de 0 a 255.")
            }
            byteArray[i] = intValue.toByte()
        }
        return byteArray
    }

    @Throws(Exception::class)
    private fun encryptInternal(text: String?): ByteArray {
        if (text.isNullOrEmpty()) {
            throw Exception("Empty string")
        }

        return try {
            cipher!!.init(Cipher.ENCRYPT_MODE, keySpec, ivSpec)
            cipher!!.doFinal(text.toByteArray())
        } catch (e: Exception) {
            throw Exception("[encrypt] " + e.message)
        }
    }

    @Throws(Exception::class)
    private fun decryptInternal(code: String?): ByteArray {
        if (code.isNullOrEmpty()) {
            throw Exception("Empty string")
        }

        return try {
            cipher!!.init(Cipher.DECRYPT_MODE, keySpec, ivSpec)
            cipher!!.doFinal(Base64.decode(code, Base64.DEFAULT))
        } catch (e: Exception) {
            throw Exception("[decrypt] " + e.message)
        }
    }

    companion object {
        @Throws(Exception::class)
        fun encrypt(valueToEncrypt: String?, key: String?, iv: String?): String {
            return if(iv != null && key != null) {
                val enc = CryptoHelper(
                    ivKey = iv, keyValue = key
                )
                Base64.encodeToString(enc.encryptInternal(valueToEncrypt), Base64.DEFAULT)
            } else {
                ""
            }
        }

        @Throws(Exception::class)
        fun decrypt(valueToDecrypt: String?, key: String?, iv: String?): String {
            return if(iv != null && key != null) {
                val enc = CryptoHelper(
                    ivKey = iv, keyValue = key
                )
                String(enc.decryptInternal(valueToDecrypt))
            } else {
                ""
            }
        }
    }
}