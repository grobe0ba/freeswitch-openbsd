diff --git a/libsofia-sip-ua/tport/ws.h b/libsofia-sip-ua/tport/ws.h
index a5a4755..0835e3a 100644
--- a/libsofia-sip-ua/tport/ws.h
+++ b/libsofia-sip-ua/tport/ws.h
@@ -28,7 +28,7 @@
 #include <openssl/ssl.h>
 #include <openssl/err.h>
 
-#if defined(_MSC_VER) || defined(__APPLE__) || defined(__FreeBSD__) || (defined(__SVR4) && defined(__sun)) 
+#if defined(_MSC_VER) || defined(__APPLE__) || defined(__FreeBSD__) || defined(__OpenBSD__) || (defined(__SVR4) && defined(__sun)) 
 #define __bswap_64(x) \
   x = (x>>56) | \
     ((x<<40) & 0x00FF000000000000) | \
