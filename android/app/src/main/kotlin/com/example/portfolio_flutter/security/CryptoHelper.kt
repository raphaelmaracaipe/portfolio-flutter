package com.example.portfolio_flutter.security

import android.util.Base64
import java.security.NoSuchAlgorithmException
import javax.crypto.Cipher
import javax.crypto.NoSuchPaddingException
import javax.crypto.spec.IvParameterSpec
import javax.crypto.spec.SecretKeySpec

class CryptoHelper {
    private val ivSpec: IvParameterSpec = IvParameterSpec(intArrayToByteArray(ivKey))
    private val keySpec: SecretKeySpec = SecretKeySpec(keyValue!!.toByteArray(), "AES")
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
        var keyValue: String? = null
        private val ivKey = intArrayOf(82, 70, 50, 50, 83, 87, 55, 54, 66, 86, 56, 51, 69, 68, 72, 56)

        @Throws(Exception::class)
        fun encrypt(valueToEncrypt: String?, key: String?): String {
            keyValue = key
            val enc = CryptoHelper()
            return Base64.encodeToString(enc.encryptInternal(valueToEncrypt), Base64.DEFAULT)
        }

        @Throws(Exception::class)
        fun decrypt(valueToDecrypt: String?, key: String?): String {
            keyValue = key
            val enc = CryptoHelper()
            return String(enc.decryptInternal(valueToDecrypt))
        }
    }
}