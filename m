Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A5FB78B7
	for <lists+linux-nvdimm@lfdr.de>; Thu, 19 Sep 2019 13:55:56 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AC9D421962301;
	Thu, 19 Sep 2019 04:55:01 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2001:41d0:602:dbe::8; helo=tartarus.angband.pl;
 envelope-from=kilobyte@angband.pl; receiver=linux-nvdimm@lists.01.org 
Received: from tartarus.angband.pl (tartarus.angband.pl
 [IPv6:2001:41d0:602:dbe::8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 61906202EBEA6
 for <linux-nvdimm@lists.01.org>; Thu, 19 Sep 2019 04:54:58 -0700 (PDT)
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
 (envelope-from <kilobyte@angband.pl>)
 id 1iAv2J-0004jP-7a; Thu, 19 Sep 2019 13:55:47 +0200
Date: Thu, 19 Sep 2019 13:55:47 +0200
From: Adam Borowski <kilobyte@angband.pl>
To: linux-nvdimm@lists.01.org, Dan Williams <dan.j.williams@intel.com>
Subject: hang in dax_pmem_compat_release on changing namespace mode
Message-ID: <20190919115547.GA17963@angband.pl>
MIME-Version: 1.0
Content-Disposition: inline
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

SGkhCklmIEkgdHJ5IHRvIGNoYW5nZSB0aGUgbW9kZSBvZiBhIGRldmRheCBuYW1lc3BhY2UgdGhh
dCdzIGluIHVzZSAobWFwcGVkIGJ5CnNvbWUgcHJvY2VzcyksIG5kY3RsIGhhbmdzOgoKWyA5NTQ2
Ljc1NDY3M10gSU5GTzogdGFzayBuZGN0bDozOTA3IGJsb2NrZWQgZm9yIG1vcmUgdGhhbiAxMjA4
IHNlY29uZHMuClsgOTU0Ni43NTQ2NzddICAgICAgIE5vdCB0YWludGVkIDUuMy4wLTAwMDQ4LWc3
ZjA5YjhiY2UwOTEgIzEKWyA5NTQ2Ljc1NDY3OV0gImVjaG8gMCA+IC9wcm9jL3N5cy9rZXJuZWwv
aHVuZ190YXNrX3RpbWVvdXRfc2VjcyIgZGlzYWJsZXMgdGhpcyBtZXNzYWdlLgpbIDk1NDYuNzU0
NjgxXSBuZGN0bCAgICAgICAgICAgRCAgICAwICAzOTA3ICAgMzg1NiAweDAwMDA0MDA0ClsgOTU0
Ni43NTQ2ODRdIENhbGwgVHJhY2U6ClsgOTU0Ni43NTQ2ODldICA/IF9fc2NoZWR1bGUrMHgyODEv
MHg2NzAKWyA5NTQ2Ljc1NDY5Ml0gID8gX19zd2l0Y2hfdG9fYXNtKzB4MzQvMHg3MApbIDk1NDYu
NzU0Njk0XSAgPyBfX3N3aXRjaF90b19hc20rMHgzNC8weDcwClsgOTU0Ni43NTQ2OTZdICBzY2hl
ZHVsZSsweDM5LzB4YTAKWyA5NTQ2Ljc1NDY5OV0gIHNjaGVkdWxlX3RpbWVvdXQrMHgyMmIvMHgz
MjAKWyA5NTQ2Ljc1NDcwMV0gID8gX19zd2l0Y2hfdG9fYXNtKzB4MzQvMHg3MApbIDk1NDYuNzU0
NzAzXSAgPyBfX3N3aXRjaF90b19hc20rMHg0MC8weDcwClsgOTU0Ni43NTQ3MDVdICA/IF9fc3dp
dGNoX3RvX2FzbSsweDM0LzB4NzAKWyA5NTQ2Ljc1NDcwN10gID8gX19zd2l0Y2hfdG8rMHgxNjIv
MHg0NDAKWyA5NTQ2Ljc1NDcxMF0gID8gYXBpY190aW1lcl9pbnRlcnJ1cHQrMHhhLzB4MjAKWyA5
NTQ2Ljc1NDcxMl0gIHdhaXRfZm9yX2NvbXBsZXRpb24rMHgxMDAvMHgxNTAKWyA5NTQ2Ljc1NDcx
NF0gID8gd2FrZV91cF9xKzB4NjAvMHg2MApbIDk1NDYuNzU0NzE4XSAgZGV2X3BhZ2VtYXBfY2xl
YW51cCsweDQ3LzB4NjAKWyA5NTQ2Ljc1NDcyMF0gIGRldm1fbWVtcmVtYXBfcGFnZXNfcmVsZWFz
ZSsweGM1LzB4MjIwClsgOTU0Ni43NTQ3MjRdICByZWxlYXNlX25vZGVzKzB4MjIxLzB4MjcwClsg
OTU0Ni43NTQ3MjhdICBkYXhfcG1lbV9jb21wYXRfcmVsZWFzZSsweDMwLzB4NTAgW2RheF9wbWVt
X2NvbXBhdF0KWyA5NTQ2Ljc1NDczMF0gID8gZGF4X3BtZW1fY29tcGF0X3JlbW92ZSsweDIwLzB4
MjAgW2RheF9wbWVtX2NvbXBhdF0KWyA5NTQ2Ljc1NDczM10gIGRldmljZV9mb3JfZWFjaF9jaGls
ZCsweDU3LzB4OTAKWyA5NTQ2Ljc1NDczNl0gIGRheF9wbWVtX2NvbXBhdF9yZW1vdmUrMHgxMy8w
eDIwIFtkYXhfcG1lbV9jb21wYXRdClsgOTU0Ni43NTQ3MzldICBudmRpbW1fYnVzX3JlbW92ZSsw
eDRlLzB4YzAKWyA5NTQ2Ljc1NDc0MV0gIGRldmljZV9yZWxlYXNlX2RyaXZlcl9pbnRlcm5hbCsw
eGQ4LzB4MWIwClsgOTU0Ni43NTQ3NDNdICB1bmJpbmRfc3RvcmUrMHhmZi8weDEzMApbIDk1NDYu
NzU0NzQ2XSAga2VybmZzX2ZvcF93cml0ZSsweDE0MC8weDFiMApbIDk1NDYuNzU0NzQ5XSAgdmZz
X3dyaXRlKzB4ZTQvMHgxZDAKWyA5NTQ2Ljc1NDc1MV0gIGtzeXNfd3JpdGUrMHg3MC8weDEwMApb
IDk1NDYuNzU0NzU0XSAgZG9fc3lzY2FsbF82NCsweDUwLzB4MTAwClsgOTU0Ni43NTQ3NTZdICBl
bnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0NC8weGE5ClsgOTU0Ni43NTQ3NThdIFJJ
UDogMDAzMzoweDdmMmQzNzVkZmFkNApbIDk1NDYuNzU0NzYyXSBDb2RlOiBCYWQgUklQIHZhbHVl
LgpbIDk1NDYuNzU0NzYzXSBSU1A6IDAwMmI6MDAwMDdmZmQ2MWVjYTRlOCBFRkxBR1M6IDAwMDAw
MjQ2IE9SSUdfUkFYOiAwMDAwMDAwMDAwMDAwMDAxClsgOTU0Ni43NTQ3NjZdIFJBWDogZmZmZmZm
ZmZmZmZmZmZkYSBSQlg6IDAwMDA1NWZiNDhmMDk4MmYgUkNYOiAwMDAwN2YyZDM3NWRmYWQ0Clsg
OTU0Ni43NTQ3NjddIFJEWDogMDAwMDAwMDAwMDAwMDAwNyBSU0k6IDAwMDA1NWZiNDhmMDk4MmYg
UkRJOiAwMDAwMDAwMDAwMDAwMDAzClsgOTU0Ni43NTQ3NjldIFJCUDogMDAwMDAwMDAwMDAwMDAw
NyBSMDg6IDAwMDAwMDAwZmZmZmZmZmYgUjA5OiAwMDAwN2ZmZDYxZWNhM2MwClsgOTU0Ni43NTQ3
NzBdIFIxMDogMDAwMDAwMDAwMDAwMDAwMCBSMTE6IDAwMDAwMDAwMDAwMDAyNDYgUjEyOiAwMDAw
MDAwMDAwMDAwMDAzClsgOTU0Ni43NTQ3NzFdIFIxMzogMDAwMDdmMmQzNzE2NmU3MCBSMTQ6IDAw
MDAwMDAwMDAwMDAwMDAgUjE1OiAwMDAwNTVmYjQ4ZjBjOTAwCgpGYWtlIHBtZW0gKG1lbW1hcD00
RyExNkcpLCB0aGUgY29tbWFuZCBpczoKICAgIG5kY3RsIGNyZWF0ZS1uYW1lc3BhY2UgLWUgbmFt
ZXNwYWNlMC4wIC1tIGZzZGF4IC1mCi1mIGlzIG5lZWRlZCBhcyBhIGxhYmVsLWxlc3MgZmFrZSBw
bWVtIG5hbWVzcGFjZSBpcyBhbHdheXMgYWN0aXZlLgoKQWNjb3JkaW5nIHRvIHRoZSBtYW4gcGFn
ZSwgcmVjb25maWd1cmluZyBpbiB0aGF0IGNhc2UgaXMgbm90IGFsbG93ZWQgKGR1aCksCmFuZCB0
aGUgb3BlcmF0aW9uIGlzIHN1cHBvc2VkIHRvIGdyYWNlZnVsbHkgZmFpbC4KCgpNZW93IQotLSAK
4qKA4qO04qC+4qC74qK24qOm4qCAIEEgTUFQMDcgKERlYWQgU2ltcGxlKSByYXNwYmVycnkgdGlu
Y3R1cmUgcmVjaXBlOiAwLjVsIDk1JSBhbGNvaG9sLArio77ioIHioqDioJLioIDio7/ioYEgMWtn
IHJhc3BiZXJyaWVzLCAwLjRrZyBzdWdhcjsgcHV0IGludG8gYSBiaWcgamFyIGZvciAxIG1vbnRo
Lgrior/ioYTioJjioLfioJrioIvioIAgRmlsdGVyIG91dCBhbmQgdGhyb3cgYXdheSB0aGUgZnJ1
aXRzIChjYW4gZHVtcCB0aGVtIGludG8gYSBjYWtlLArioIjioLPio4TioIDioIDioIDioIAgZXRj
KSwgbGV0IHRoZSBkcmluayBhZ2UgYXQgbGVhc3QgMy02IG1vbnRocy4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlz
dApMaW51eC1udmRpbW1AbGlzdHMuMDEub3JnCmh0dHBzOi8vbGlzdHMuMDEub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtbnZkaW1tCg==
