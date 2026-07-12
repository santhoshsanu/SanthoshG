* AWS Certificate Manager (ACM) is a managed AWS service that provisions, manages, and automatically renews SSL/TLS certificates. These certificates are used to encrypt communication between clients and applications, enabling HTTPS instead of HTTP.

Typically, we request a certificate for our domain (for example, example.com or *.example.com). ACM validates domain ownership using either DNS validation or email validation. DNS validation is the most common method, where ACM provides a CNAME record that we add to our Route 53 hosted zone. Once the domain is validated, the certificate is issued.

After the certificate is issued, we attach it to AWS services such as an Application Load Balancer (ALB), CloudFront, or API Gateway. The load balancer then terminates the SSL/TLS connection and serves traffic over HTTPS.

One of the biggest advantages of ACM is that it automatically renews certificates, so we don't have to manually track expiry dates.