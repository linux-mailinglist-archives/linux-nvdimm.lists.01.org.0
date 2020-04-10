Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 137171A446D
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 Apr 2020 11:23:34 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5D21A100BC453;
	Fri, 10 Apr 2020 02:24:21 -0700 (PDT)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=66.163.188.204; helo=sonic311-23.consmr.mail.ne1.yahoo.com; envelope-from=mjakabdullah@gmail.com; receiver=<UNKNOWN> 
Received: from sonic311-23.consmr.mail.ne1.yahoo.com (sonic311-23.consmr.mail.ne1.yahoo.com [66.163.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 89B4B10112D02
	for <linux-nvdimm@lists.01.org>; Fri, 10 Apr 2020 02:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586510609; bh=GR4TRCXK6wRteJXXqtI/y/2pwYNeSYeNMXUPo1+ojQ4=; h=Date:From:Reply-To:Subject:References:From:Subject; b=IF3JHPBsxq98AqlhfE/VsHbSbSzUuhxZ9blycv1JNuCMhqDQOnYDIBscQZfhKM9ejuzIW/AMgaj6xBAroBfmga69w4qJYvA8w12W1YGdu3LIlV7kIyhjO8aycGYmgqKqzY4qEZJI2VFK8tDeU0N/ML88lltc6Dw9XG/KEO/1WYmgpo0TJ7/q7xOrBVOSsC4MG5t3YmxLjRoqZp5O4dzBCmR2jzYNd9HEisVj9amXAp0lBxDs/tKgw/rN8KkZF9knUeDoSCt1ZsWd2/yqab20INvV4TMioDmlNXNjTtEeWXHHCi1Vux66u1poRYrBVTeshNlvtjCDt7bSNv8MBOeRzw==
X-YMail-OSG: TdZtDwMVM1muDKscW.I6TkXzEwvDC91C4utMEIuxDiVvIMKXvzL1OeeNspPq.du
 6cEJCeaQuBV1sHtYmj3kYZITSWM1KMGoSFOukAD5HPc.grnBMOLjvrO9n5h9y_AkoDSpUM.8jpe9
 LEp3PiQD4ZEFyHV0OP07FrkgTk577KoQc8pFBRbAkK_Jo6K2K2WbX3SbWCN6gVVxVsF_ktV68RqF
 WSJQwnmnTILUgQ7VJ6K2R_YtPyQaH5bJ580HXTaJMwQD1WJXeXWUU04qZkJnRwJdRdnBZhRiPXu_
 F3OWYERoth2jrokqYCozMgoXmx.KePvGgOkoIxaVpT8MFbIulG_LlojodoKaTrtoC6RuPwjWzMxz
 Pio7zpKl48l7z_pwilZeq35wz.Gcr31xzyqcwDGsmhA3p9aE6X7SH1gzCEKvnfhY7K1nkAyxF9OS
 Sv7SgMiBaIvHD3.eSb03gLPApxGawEYP06Y7LsXUjvecSDZz4loiXtEqtdaTlTyo1MoJEHzhZ2uP
 FmXr3wBOXSF7VTynOa8of8dYhHp85V4aZNr2XelLSNtSKTVHWefCoc3yMld0o.i.EK_bHX1WJvoE
 AmEPoquXPmgQqjjtSpU3GxdeOsfY6a6EgwEB.EdsIRGeer72C8IDVjT_wsUPomzJOVhcgiOY0ZrQ
 RCoA4RIIr5miWKokBx.eqk5uKgigQH0b0nnBCjb1OzPD9qv7mS3amPdhiYZBbflcTKmB.u.hhrBu
 oiEqx21jwv_ksAVdvPEkck6kL5FEDSTzkk1.MIAD3Rtevy2a7X595R5dtqpTocBEUG8TxLkIZgyB
 mSnN4gxDzTLn8Wm05r51_QKRZG2uqVxk6ryo7y09g6ZQeqJvpGx0lAIXAeJrv2h3dBnfMWvC_2Ra
 uhj1Sm6Gc71ueK_3bnUWpa1KGGBbrD6_r21OWouetw3mQZ9eXVkuS.6pECVup1VQDa_qRRA8dU40
 qc9J0VJMZ152b5P7GN6eirJOhMxjnPlF45oTPNxom9r0TdxMtaJLun_96hoZUl1Q34L8fScSGdKH
 IlbT0CUhKBc.gTrK81vKh_sV4VZCBVkv9yUR8XbqCl0y86weWMXvwaW.YzMywtJr76P7zUut7pac
 5Sqej5bU9Tl_eDxcmJei4CRMU6QYqwh042H9QuGUC7HHPalRkjR9Bl8V0l.bJ.tx9_N9GK1kM6J7
 O08dIvxGFsO631me1zura5NowdU5A.NXJBjAQkuP6yY2FwGA3bRKB1gQL23DR.R8CrEGlodTwD2x
 Os.Oe_cJ0uLl.0wMat9f_KJjiu_Q14MDxp_wx7f.oMyJWoup4kw0NDvGAXduJU2PrumOohBs-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 10 Apr 2020 09:23:29 +0000
Date: Fri, 10 Apr 2020 09:23:25 +0000 (UTC)
From: Jak Abdullah mishail <mjakabdullah@gmail.com>
Message-ID: <1429137007.3649957.1586510605134@mail.yahoo.com>
Subject: I NEED YOUR ASSISTANCE AND CO-OPERATION TO INVEST IN YOUR COUNTRY,
MIME-Version: 1.0
References: <1429137007.3649957.1586510605134.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15620 YMailNodin Mozilla/5.0 (Windows NT 6.3; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0
Message-ID-Hash: CC5SHT7YYHRMCDIDJSKZ6BWLFMW2VZDW
X-Message-ID-Hash: CC5SHT7YYHRMCDIDJSKZ6BWLFMW2VZDW
X-MailFrom: mjakabdullah@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: mishailjakabdullah@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CC5SHT7YYHRMCDIDJSKZ6BWLFMW2VZDW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

R3JlZXRpbmcsDQoNCk15IE5hbWUgaXMgTXIuSmFrIEFiZHVsbGFoIG1pc2hhaWwgZnJvbSBEYW1h
c2N1cyBTeXJpYSwgYW5kIEkgYW0gbm93IHJlc2lnbmVkIGZyb20gdGhlIGdvdmVybm1lbnQuIEkg
YW0gYSBtZW1iZXIgb2YgYW4gb3Bwb3NpdGlvbiBwYXJ0eSBnb3Zlcm5tZW50IGluIFN5cmlhIGFu
ZCBhIGJ1c2luZXNzIG1hbiBhbHNvLA0KDQpJIG5lZWQgYSBmb3JlaWduIHBhcnRuZXIgdG8gZW5h
YmxlIG1lIHRyYW5zcG9ydCBteSBpbnZlc3RtZW50IGNhcGl0YWwgYW5kIHRoZW4gUmVsb2NhdGUg
d2l0aCBteSBmYW1pbHksIGhvbmVzdGx5IEkgd2lzaCBJIHdpbGwgZGlzY3VzcyBtb3JlIGFuZCBn
ZXQgYWxvbmcgSSBuZWVkIGEgcGFydG5lciBiZWNhdXNlIG15IGludmVzdG1lbnQgY2FwaXRhbCBp
cyBpbiBteSBpbnRlcm5hdGlvbmFsIGFjY291bnQuIEFtIGludGVyZXN0ZWQgaW4gYnV5aW5nIFBy
b3BlcnRpZXMsIGhvdXNlcywgYnVpbGRpbmcgcmVhbCBlc3RhdGVzIGFuZCBzb21lIHRvdXJpc3Qg
cGxhY2VzLCBteSBjYXBpdGFsIGZvciBpbnZlc3RtZW50IGlzICgkMTYuNSBtaWxsaW9uIFVTRCkg
TWVhbndoaWxlIGlmIHRoZXJlIGlzIGFueSBwcm9maXRhYmxlIGludmVzdG1lbnQgdGhhdCB5b3Ug
aGF2ZSBzbyBtdWNoIGV4cGVyaWVuY2Ugb24gaXQgdGhlbiB3ZSBjYW4gam9pbiB0b2dldGhlciBh
cyBwYXJ0bmVycyBzaW5jZSBJ4oCZbSBhIGZvcmVpZ25lci4NCg0KSSBjYW1lIGFjcm9zcyB5b3Vy
IGUtbWFpbCBjb250YWN0IHRocm91Z2ggcHJpdmF0ZSBzZWFyY2ggd2hpbGUgaW4gbmVlZCBvZiB5
b3VyIGFzc2lzdGFuY2UgYW5kIEkgZGVjaWRlZCB0byBjb250YWN0IHlvdSBkaXJlY3RseSB0byBh
c2sgeW91IGlmIHlvdSBrbm93IGFueSBMdWNyYXRpdmUgQnVzaW5lc3MgSW52ZXN0bWVudCBpbiB5
b3VyIENvdW50cnkgSSBjYW4gaW52ZXN0IG15IE1vbmV5IHNpbmNlIG15IENvdW50cnkgU3lyaWEg
U2VjdXJpdHkgYW5kIEVjb25vbWljIEluZGVwZW5kZW50IGhhcyBsb3N0IHRvIHRoZSBHcmVhdGVz
dCBMb3dlciBsZXZlbCwgYW5kIG91ciBDdWx0dXJlIGhhcyBsb3N0IGZvcmV2ZXIgaW5jbHVkaW5n
IG91ciBoYXBwaW5lc3MgaGFzIGJlZW4gdGFrZW4gYXdheSBmcm9tIHVzLiBPdXIgQ291bnRyeSBo
YXMgYmVlbiBvbiBmaXJlIGZvciBtYW55IHllYXJzIG5vdy4NCg0KSWYgeW91IGFyZSBjYXBhYmxl
IG9mIGhhbmRsaW5nIHRoaXMgYnVzaW5lc3MgQ29udGFjdCBtZSBmb3IgbW9yZSBkZXRhaWxzIGkg
d2lsbCBhcHByZWNpYXRlIGl0IGlmIHlvdSBjYW4gY29udGFjdCBtZSBpbW1lZGlhdGVseS4NCllv
dSBtYXkgYXMgd2VsbCB0ZWxsIG1lIGxpdHRsZSBtb3JlIGFib3V0IHlvdXJzZWxmLiBDb250YWN0
IG1lIHVyZ2VudGx5IHRvIGVuYWJsZSB1cyBwcm9jZWVkIHdpdGggdGhlIGJ1c2luZXNzLg0KDQpJ
IHdpbGwgYmUgd2FpdGluZyBmb3IgeW91ciByZXNwb25kLg0KDQpTaW5jZXJlbHkgWW91cnMsDQoN
CkphayBBYmR1bGxhaCBtaXNoYWlsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxp
c3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1s
ZWF2ZUBsaXN0cy4wMS5vcmcK
