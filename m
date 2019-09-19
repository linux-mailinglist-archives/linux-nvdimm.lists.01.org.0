Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C816CB7E76
	for <lists+linux-nvdimm@lfdr.de>; Thu, 19 Sep 2019 17:47:16 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1BE8A202EBEC9;
	Thu, 19 Sep 2019 08:46:21 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2001:41d0:602:dbe::8; helo=tartarus.angband.pl;
 envelope-from=kilobyte@angband.pl; receiver=linux-nvdimm@lists.01.org 
Received: from tartarus.angband.pl (tartarus.angband.pl
 [IPv6:2001:41d0:602:dbe::8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 0D1ED21959CB2
 for <linux-nvdimm@lists.01.org>; Thu, 19 Sep 2019 08:46:18 -0700 (PDT)
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
 (envelope-from <kilobyte@angband.pl>)
 id 1iAyeC-0006aV-P0; Thu, 19 Sep 2019 17:47:08 +0200
Date: Thu, 19 Sep 2019 17:47:08 +0200
From: Adam Borowski <kilobyte@angband.pl>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: hang in dax_pmem_compat_release on changing namespace mode
Message-ID: <20190919154708.GA24650@angband.pl>
References: <20190919115547.GA17963@angband.pl>
 <CAPcyv4jYE_vmEqe+m7spaXV4FDgHLJpE9cp3Ry2e8vU0JZEFCA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4jYE_vmEqe+m7spaXV4FDgHLJpE9cp3Ry2e8vU0JZEFCA@mail.gmail.com>
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

T24gVGh1LCBTZXAgMTksIDIwMTkgYXQgMDg6MTA6NDdBTSAtMDcwMCwgRGFuIFdpbGxpYW1zIHdy
b3RlOgo+IE9uIFRodSwgU2VwIDE5LCAyMDE5IGF0IDQ6NTYgQU0gQWRhbSBCb3Jvd3NraSA8a2ls
b2J5dGVAYW5nYmFuZC5wbD4gd3JvdGU6Cj4gPiBIaSEKPiA+IElmIEkgdHJ5IHRvIGNoYW5nZSB0
aGUgbW9kZSBvZiBhIGRldmRheCBuYW1lc3BhY2UgdGhhdCdzIGluIHVzZSAobWFwcGVkIGJ5Cj4g
PiBzb21lIHByb2Nlc3MpLCBuZGN0bCBoYW5nczoKPiAKPiBJcyBpdCBtZXJlbHkgbWFwcGVkLCBv
ciBtaWdodCB0aGUgcGFnZXMgYmUgYWN0aXZlbHkgcGlubmVkIC8gaW4gdXNlIGJ5Cj4gYW5vdGhl
ciBwYXJ0IG9mIHRoZSBrZXJuZWw/IFRoZSBrZXJuZWwgaGFzIG5vIGNob2ljZSBidXQgdG8gd2Fp
dCBmb3IKPiBhY3RpdmUgcGFnZSBwaW5zIHRvIGRyYWluLiBDYW4geW91IGdldCBhIHN0YWNrIHRy
YWNlIG9mIHRoZSBwcm9jZXNzCj4gd2l0aCB0aGUgZGV2LWRheCBpbnN0YW5jZSBtYXBwZWQ/CgpM
b29rcyBsaWtlIHRoZSBiZWhhdmlvdXIgaXMgZGlmZmVyZW50IGRlcGVuZGluZyBvbiB3aGF0IHRo
ZSBvdGhlciBwcm9jZXNzCmlzOgoqIHdpdGggcWVtdSwgdGhlIGhhbmcgaXMgMTAwJSByZXByb2R1
Y2libGUsIHRoZSBndWVzdCBjb250aW51ZXMgdG8gd29yayBhbmQKICBjbGVhbmx5IGV4aXRzIC0t
IHFlbXUgZG9lcyBub3QgZXhpdCBvbiBpdHMgb3duICh1bmxpa2Ugbm9ybWFsIGNhc2UpIGJ1dAog
IFNJR1RFUk0gdGVybWluYXRlcyBpdCBjb3JyZWN0bHkuICBUaHVzLCBxZW11IGlzIG5vdCBzdHVj
aywgb25seSBuZGN0bCBpcy4KKiB3aXRoIG1lcmUgbW1hcCgpIChJJ3ZlIHVzZWQgdm1lbWNhY2hl
KSBuZGN0bCBhbGxvd3MKICByZWNvbmZpZ3VyaW5nIHRoZSBuYW1lc3BhY2UuICBObyBoYW5nLgoK
TXkgd2F5IHRvIHN0YXJ0IHFlbXUgaXM6Ci4tLS0tCiMhL2Jpbi9zaApORVQ9Ii1uZXQgYnJpZGdl
IC1uZXQgbmljIgpESVNLPWVvYW4tZGV2ZGF4LmRpc2sKCmV4ZWMgcWVtdS1zeXN0ZW0teDg2XzY0
IC1lbmFibGUta3ZtIC1tIDQwOTYsc2xvdHM9MixtYXhtZW09MTZHIC1zbXAgOCAkTkVUIFwKIC1k
cml2ZSBpZj1ub25lLGlkPWhkLGZpbGU9IiRESVNLIixmb3JtYXQ9cmF3LGNhY2hlPXVuc2FmZSxk
aXNjYXJkPW9uIFwKIC1kZXZpY2UgdmlydGlvLXNjc2ktcGNpLGlkPXNjc2kgLWRldmljZSBzY3Np
LWhkLGRyaXZlPWhkIFwKIC1NIHBjLG52ZGltbSxudmRpbW0tcGVyc2lzdGVuY2U9bWVtLWN0cmwg
XAogLW9iamVjdCBtZW1vcnktYmFja2VuZC1maWxlLGlkPW1lbTEsc2hhcmU9b24sbWVtLXBhdGg9
L2Rldi9kYXgwLjAsc2l6ZT00MjI1NzYxMjgwLGFsaWduPTJNLHBtZW09b24gXAogLWRldmljZSBu
dmRpbW0saWQ9bnZkaW1tMSxtZW1kZXY9bWVtMSxsYWJlbC1zaXplPTI1NksgXAogLXZuYyA6NQpg
LS0tLQoKCk1lb3chCi0tIAriooDio7TioL7ioLviorbio6bioIAgQSBNQVAwNyAoRGVhZCBTaW1w
bGUpIHJhc3BiZXJyeSB0aW5jdHVyZSByZWNpcGU6IDAuNWwgOTUlIGFsY29ob2wsCuKjvuKggeKi
oOKgkuKggOKjv+KhgSAxa2cgcmFzcGJlcnJpZXMsIDAuNGtnIHN1Z2FyOyBwdXQgaW50byBhIGJp
ZyBqYXIgZm9yIDEgbW9udGguCuKiv+KhhOKgmOKgt+KgmuKgi+KggCBGaWx0ZXIgb3V0IGFuZCB0
aHJvdyBhd2F5IHRoZSBmcnVpdHMgKGNhbiBkdW1wIHRoZW0gaW50byBhIGNha2UsCuKgiOKgs+Kj
hOKggOKggOKggOKggCBldGMpLCBsZXQgdGhlIGRyaW5rIGFnZSBhdCBsZWFzdCAzLTYgbW9udGhz
LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1u
dmRpbW0gbWFpbGluZyBsaXN0CkxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKaHR0cHM6Ly9saXN0
cy4wMS5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udmRpbW0K
