import 'dart:convert';

import 'package:http/http.dart' as http;

Future createVerifiablePresentation() async {
  final url = 'https://api.entity.hypersign.id/api/v1/presentation';

  final body = {
    "credentialDocuments": [
      {
        "@context": [
          "https://www.w3.org/2018/credentials/v1",
          {
            "hs": "https://api.jagrat.hypersign.id/hypersign-protocol/hidnode/ssi/schema/sch:hid:testnet:zEinwkuP5XUtU2AmArh4rqbCLbwzZRebBQzitCSafiiSG:1.0:"
          },
          {
            "name": "hs:name"
          },
          {
            "rollNo": "hs:rollNo"
          },
          "https://w3id.org/security/suites/ed25519-2020/v1"
        ],
        "id": "vc:hid:testnet:zDm9qhMncSGnudGYquzz3mGfV8yahS4yKcWmeWTb5pcxe",
        "type": ["VerifiableCredential", "Degree"],
        "expirationDate": "2027-12-10T18:30:00Z",
        "issuanceDate": "2023-12-18T13:31:00Z",
        "issuer": "did:hid:testnet:z6y1cC2BCFw2ZoAcxcSZNAFE87xSQNqoGTAR4xxoWFD9",
        "credentialSubject": {
          "name": "Raj",
          "rollNo": 20,
          "id": "did:hid:testnet:z2ikbFoMbenw3ajCd5jVzrncCXycdkbeAWte3nLpdrjHu"
        },
        "credentialSchema": {
          "id": "sch:hid:testnet:zEinwkuP5XUtU2AmArh4rqbCLbwzZRebBQzitCSafiiSG:1.0",
          "type": "JsonSchemaValidator2018"
        },
        "credentialStatus": {
          "id": "https://api.jagrat.hypersign.id/hypersign-protocol/hidnode/ssi/credential/vc:hid:testnet:zDm9qhMncSGnudGYquzz3mGfV8yahS4yKcWmeWTb5pcxe",
          "type": "CredentialStatusList2017"
        },
        "proof": {
          "type": "Ed25519Signature2020",
          "created": "2023-12-18T13:32:40Z",
          "verificationMethod": "did:hid:testnet:z6y1cC2BCFw2ZoAcxcSZNAFE87xSQNqoGTAR4xxoWFD9#key-1",
          "proofPurpose": "assertionMethod",
          "proofValue": "z3dW8HXSzSQv2khSAAHZSNa6WC16YR6dpQFAxvwN8NMvkfxFsKKxXfDpNJiZbnHUwNUjv7Dq41zWmcsU7xfiyiLg3"
        }
      }
    ],
    "holderDid": "did:hid:testnet:z2ikbFoMbenw3ajCd5jVzrncCXycdkbeAWte3nLpdrjHu",
    "challenge": "Raj",
    "domain": "example.com"
  };

  final headers = {
    'Content-Type': 'application/json',
  };

  return await http.post(Uri.parse(url), headers: headers, body: jsonEncode(body));
}