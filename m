Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1887EFD77
	for <lists+linux-nvdimm@lfdr.de>; Tue,  5 Nov 2019 13:45:26 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CAB88100DC41B;
	Tue,  5 Nov 2019 04:48:07 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=74.6.128.32; helo=sonic304-9.consmr.mail.bf2.yahoo.com; envelope-from=jamesmorganrrrt@yahoo.com; receiver=<UNKNOWN> 
Received: from sonic304-9.consmr.mail.bf2.yahoo.com (sonic304-9.consmr.mail.bf2.yahoo.com [74.6.128.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D04C2100DC41A
	for <linux-nvdimm@lists.01.org>; Tue,  5 Nov 2019 04:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1572957922; bh=Gp5v5w3d9Epkt3czg5WXDldv9bIzyIT4W2EZP2h3s9Y=; h=Date:From:Reply-To:Subject:References:From:Subject; b=cwRtyR3RbJ2OEOkr79iSrKWrYge89MYkrO53wRiAe83FarzpOylE4XNZClzATpjB23o0xfRlKk/auGNL5oUhJbLoGF1HhHHUq1i5GWBztVosNFAmVMn1AFM2LP1h8OjrE3Qi/IHM76uzU2LxxFA6UvYjmvdhWitZR180hQ/eXhtknak+b970ywYaR80Wj4zZi9chgSvGVy7yIWKNgtEmZSOtVCZSwIJJ1GgXpF1lr4cz3s1V8BmMMUWT91fCl9VfFVj4EnbPrzKHrd0Xf0amgA0g/aFyxv7T/yeASnmbNSnxn1WTLWRfEiQcPHQmpkwxnYBLG6eINqaw/1FZT8Cz8g==
X-YMail-OSG: jWc3aPcVM1n0MUpMWXIOs2aSyeUSefHysXXRpL6nAfgKlVG0m7Mun6kUb8wW_Hk
 i7tqyDVrpM7nDd6r5.kuCpCmp8cnW5vYGBGJRbGret7IKLdS6kKxZMpDGNtKOtLR1uM0tQ1tKAEq
 1E0kceQSzSXEAs2XZud1npl.vDHzJEANsoyCbQNr5S8tYP.3TJZNNzGKtqnpZ6gYbZ8OJrBfRcNy
 K5kM6ocwHuFf2aqbk2QN5rE7bRSF8IWSg4MNWJHR.lLuKwgOktX7wvMmOkkPZSGVyL0t6FTTGuLy
 PTQLo1OiQUrq2w7BUfdSvTy7vZthKF3AOMaEM3diWgpg1tfGGnc462PXom.l1_Ngs1K.IzC98bNQ
 QtXz8OsxfMRLASNSfw0sY3sUv8cv85J1X236I.3vu_3ROFHw3PP6gBZJsxLivCSyyLil_.kZgOCO
 EvDAJblcflsX08iCx6ox2pMgrIGkOjPGulCoCGOFqXM1.CPla9UvsAZs85bo_SENcWQQdOXZiktu
 JrO74JWGZ4UGo8mP5e2f8X5iRZ121gi1gW0kisuhRgNUPFBOxpTDw415554Bjbujm2i4Dzgq_qk6
 T7LakyJowt__YCAEZwrEf1BAD.gh4EAHux9_MvbZX4HiSLhv3YsSDW7g_CKh9Ilb400nqthIZZrZ
 zlBhhQI3mdV5r8HjKrZTCXMb0v58mjXCvAelhANHg_Rs5GZIuHTFZb94EokWGE2RNPG7.veESMMU
 tl.knA0.swuwjM62qEE.3jqEtelsHIFJB.QUXgL8lw87fdUwGIATyZ8jS_IOA_Ky5MdyjuP3mA_Y
 Q5nfcNy7FX.f06HontpedAR7aWQ3nR5d969BQVhCUIXm69L4ncOaVfTZhJlbEwj3zHIuo_I9Cy51
 niIafnIyLCJvv8Jg2YON4ePLViI9KyRyrz6bFcTLLP1ENRFWirFlX4Tgrkka80Jz8CaksjF6Nd4_
 .ideo012FlD1K8Co0jfhsaavPsW2qZH67XOHl_ELkRUJONhEBgV4unqnyQmM7TvKcMpIEsM3st2h
 7KjjbY2SrCy5tGHdPxYqx_aR.gDtKiOyg3ZlMXrCT1C3prFVHc4Vfkv3nctpryMbRNP.EX0H__XO
 CVmcTCyKyAuYGZb9s0UzOr9BxT1NT8jgxUqfWEG.LdA_ogODWlStGRlY7I4GodrzmW6Ghejga8KY
 .SciKCjY9vmMzJ_ae7yzhSFqxOxKsaCRCjBcuJebUZtVfLZHEYybBA1Q85cACPR_cckJkRNRwg23
 B40MLv.7dkMRSclCFjR7w.EM6ItUAjrBMCuvly7oQr8stT3oDvtdwSsrH51Se2Dm93VCOwpgSCw-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Tue, 5 Nov 2019 12:45:22 +0000
Date: Tue, 5 Nov 2019 12:45:18 +0000 (UTC)
From: James Morgan <jamesmorganrrrt@yahoo.com>
Message-ID: <492457139.894696.1572957918734@mail.yahoo.com>
Subject: Greetings to you,
MIME-Version: 1.0
References: <492457139.894696.1572957918734.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.14638 YMailNorrin Mozilla/5.0 (Windows NT 6.1; rv:70.0) Gecko/20100101 Firefox/70.0
Message-ID-Hash: RDUDF7TQWEVRPAHGYOM7JUDIEPKXRECO
X-Message-ID-Hash: RDUDF7TQWEVRPAHGYOM7JUDIEPKXRECO
X-MailFrom: jamesmorganrrrt@yahoo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: James Morgan <jamesmorganw@yahoo.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RDUDF7TQWEVRPAHGYOM7JUDIEPKXRECO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQpHcmVldGluZ3MgdG8geW91LA0KTXkgbmFtZSBpcyBNci5KYW1lcyBNb3JnYW4sIGZyb20gVG91
bG91c2UgRnJhbmNlLiBJIGhhdmUgYmVlbiBzdWZmZXJpbmcgZnJvbSBjYW5jZXIgZGlzZWFzZSBh
bmQgdGhlIGRvY3RvciBzYXlzIHRoYXQgSSBoYXZlIGp1c3QgYSBzaG9ydCB0aW1lIHRvIGxpdmUu
IEZvciB0aGUgcGFzdCBUd2VsdmUgeWVhcnMsIEkgaGF2ZSBiZWluZyBkZWFsaW5nIG9uIGdvbGQg
ZXhwb3J0YXRpb24sIGJlZm9yZSBmYWxsaW5nIGlsbCBkdWUgdG8gdGhlIENhbmNlci4gSSBtYWRl
IGEgbG90IG9mIG1vbmV5IGZyb20gdGhlIHNhbGVzIG9mIEdvbGQgYW5kIGNvdHRvbiwgSSBtYXJy
aWVkIHRvIG15IGxhdGUgd2lmZSBhZnRlciBtYW55IHllYXJzIG9mIG1hcnJpYWdlIHdlIGhhZCBu
byBjaGlsZCBvZiBvdXIgb3duLsKgIEkgYW0gdmVyeSBzaWNrIGFuZCBhY2NvcmRpbmcgdG8gdGhl
IGRvY3RvciwgSSB3aWxsIG5vdCBzdXJ2aXZlIHRoZSBzaWNrbmVzcy4NClRoZSB3b3JzdCBvZiBp
dCBhbGwgaXMgdGhhdCBJIGRvIG5vdCBoYXZlIGFueSBmYW1pbHkgbWVtYmVycyBvciBjaGlsZHJl
biB0byBpbmhlcml0IG15IHdlYWx0aC5JIGFtIHdyaXRpbmcgdGhpcyBsZXR0ZXIgbm93IHRocm91
Z2ggdGhlIGhlbHAgb2YgdGhlIGNvbXB1dGVyIGJlc2lkZSBteSBzaWNrIGJlZC5JIGhhdmUgJDIu
NSBNaWxsaW9uIFVTIERvbGxhcnMgZGVwb3NpdGVkIGluIHRoZSBGaW5hbmNpYWwgSG91c2UgT3Zl
cnNlYXMgYW5kIEkgYW0gd2lsbGluZyB0byBpbnN0cnVjdGlvbiB0byB0cmFuc2ZlciB0aGUgc2Fp
ZCBmdW5kIHRvIHlvdSBhcyBteSBmb3JlaWduIFRydXN0ZWUuIFlvdSB3aWxsIGFwcGx5IHRvIHRo
ZSBGaW5hbmNpYWwgSG91c2UgZm9yIGNsYWltaW5nIG9mIHRoZSBmdW5kLCB0aGF0IHRoZXkgc2hv
dWxkIHJlbGVhc2UgdGhlIGZ1bmQgdG8geW91LCBidXQgeW91IHdpbGwgYXNzdXJlIG1lIHRoYXQg
eW91IHdpbGwgdGFrZSA1MCUgb2YgdGhlIGZ1bmQgYW5kIGdpdmUgNTAlIHRvIHRoZSBvcnBoYW5h
Z2VzIGhvbWUgaW4geW91ciBjb3VudHJ5IGZvciBteSBzb3VsIHRvIHJlc3QgYWZ0ZXIgaSBoYXZl
IGdvbmUuIEluIG15IG5leHQgZW1haWwsIEkgd2lsbCBzZW5kIHlvdSB0aGUgY29weSBvZiB0aGUg
Q2VydGlmaWNhdGUgb2YgRGVwb3NpdCB3aGljaCB3aWxsIGVuYWJsZSB5b3UgYXBwbHkgYW5kIHJl
Y2VpdmUgdGhlIG1vbmV5IHdpdGggZWFzZS5QbGVhc2UgcmVzcG9uZCB0byBtZSBpbW1lZGlhdGVs
eSBvbiBteSBwcml2YXRlIGVtYWlsIGFkZHJlc3Mgd2hlcmUgaSBhbSBhYmxlIHRvIGFjY2VzcyBt
eSBlbWFpbHMgcXVpY2tseSAoamFtZXNtb3JnYW53QHlhaG9vLmNvbSkgZm9yIGZ1cnRoZXIgZGV0
YWlscyBhbmQgaW5zdHJ1Y3Rpb25zIHNpbmNlIEkgYW0gaW4gdGhlIGVuZCB0aW1lcyBvZiBteSBs
aWZlIGR1ZSB0byB0aGUgY2FuY2VyIGRpc2Vhc2UgbWFueSBkYW1hZ2VzIG9mIG9yZ2FucyBpbiBt
eSBib2R5LiBIb3BpbmcgdG8gcmVjZWl2ZSB5b3VyIHJlc3BvbnNlIGFzIHNvb24gYXMgcG9zc2li
bGUuDQpNeSBSZWdhcmRzLA0KTXIgSmFtZXMgTW9yZ2FuDQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxp
bnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBs
aW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
