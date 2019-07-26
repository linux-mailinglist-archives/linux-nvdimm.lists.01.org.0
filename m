Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA16767FB
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Jul 2019 15:41:38 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DFE0C212E13DB;
	Fri, 26 Jul 2019 06:44:03 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sashal@kernel.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 31D0F212DD354
 for <linux-nvdimm@lists.01.org>; Fri, 26 Jul 2019 06:44:02 -0700 (PDT)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 19B4022CD4;
 Fri, 26 Jul 2019 13:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1564148495;
 bh=NJDlIH4KGJqn4e9q5kwzVQH5pxSA8DwV0qiVlK5QMoo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YzWugQCdGbMv51m2eVl+HBHzUwpZAoc1dYyjc1/Uu7wtrZvyd3nUaLzaJgx9jMu+z
 pLsHz6Ntswee9AGC+8NE8XoJBqRLRCRFGB5oycASG+lyvoWeUvkKH06juXfPcfS2DZ
 I3IzumMl2SO1I6NmaSDIj/Pgq/U9KtDQhFUxHnww=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 67/85] device-dax: fix memory and resource leak if
 hotplug fails
Date: Fri, 26 Jul 2019 09:39:17 -0400
Message-Id: <20190726133936.11177-67-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726133936.11177-1-sashal@kernel.org>
References: <20190726133936.11177-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>,
 Takashi Iwai <tiwai@suse.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Dave Hansen <dave.hansen@intel.com>,
 Yaowei Bai <baiyaowei@cmss.chinamobile.com>, Ross Zwisler <zwisler@kernel.org>,
 Sasha Levin <sashal@kernel.org>, linux-nvdimm@lists.01.org,
 James Morris <jmorris@namei.org>, Huang Ying <ying.huang@intel.com>,
 Borislav Petkov <bp@suse.de>, Tom Lendacky <thomas.lendacky@amd.com>,
 Pavel Tatashin <pasha.tatashin@soleen.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Fengguang Wu <fengguang.wu@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

RnJvbTogUGF2ZWwgVGF0YXNoaW4gPHBhc2hhLnRhdGFzaGluQHNvbGVlbi5jb20+CgpbIFVwc3Ry
ZWFtIGNvbW1pdCAzMWU0Y2E5MmE3ZGQ0Y2RlYmQ3ZmUxNDU2YjNiMGI2YWNlOWE4MTZmIF0KClBh
dGNoIHNlcmllcyAiIkhvdHJlbW92ZSIgcGVyc2lzdGVudCBtZW1vcnkiLCB2Ni4KClJlY2VudGx5
LCBhZGRpbmcgYSBwZXJzaXN0ZW50IG1lbW9yeSB0byBiZSB1c2VkIGxpa2UgYSByZWd1bGFyIFJB
TSB3YXMKYWRkZWQgdG8gTGludXguICBUaGlzIHdvcmsgZXh0ZW5kcyB0aGlzIGZ1bmN0aW9uYWxp
dHkgdG8gYWxzbyBhbGxvdyBob3QKcmVtb3ZpbmcgcGVyc2lzdGVudCBtZW1vcnkuCgpXZSAoTWlj
cm9zb2Z0KSBoYXZlIGFuIGltcG9ydGFudCB1c2UgY2FzZSBmb3IgdGhpcyBmdW5jdGlvbmFsaXR5
LgoKVGhlIHJlcXVpcmVtZW50IGlzIGZvciBwaHlzaWNhbCBtYWNoaW5lcyB3aXRoIHNtYWxsIGFt
b3VudCBvZiBSQU0gKH44RykKdG8gYmUgYWJsZSB0byByZWJvb3QgaW4gYSB2ZXJ5IHNob3J0IHBl
cmlvZCBvZiB0aW1lICg8MXMpLiAgWWV0LCB0aGVyZQppcyBhIHVzZXJsYW5kIHN0YXRlIHRoYXQg
aXMgZXhwZW5zaXZlIHRvIHJlY3JlYXRlICh+MkcpLgoKVGhlIHNvbHV0aW9uIGlzIHRvIGJvb3Qg
bWFjaGluZXMgd2l0aCAyRyBwcmVzZXJ2ZWQgZm9yIHBlcnNpc3RlbnQKbWVtb3J5LgoKQ29weSB0
aGUgc3RhdGUsIGFuZCBob3RhZGQgdGhlIHBlcnNpc3RlbnQgbWVtb3J5IHNvIG1hY2hpbmUgc3Rp
bGwgaGFzCmFsbCA4RyBhdmFpbGFibGUgZm9yIHJ1bnRpbWUuICBCZWZvcmUgcmVib290LCBvZmZs
aW5lIGFuZCBob3RyZW1vdmUKZGV2aWNlLWRheCAyRywgY29weSB0aGUgbWVtb3J5IHRoYXQgaXMg
bmVlZGVkIHRvIGJlIHByZXNlcnZlZCB0byBwbWVtMApkZXZpY2UsIGFuZCByZWJvb3QuCgpUaGUg
c2VyaWVzIG9mIG9wZXJhdGlvbnMgbG9vayBsaWtlIHRoaXM6CgoxLiBBZnRlciBib290IHJlc3Rv
cmUgL2Rldi9wbWVtMCB0byByYW1kaXNrIHRvIGJlIGNvbnN1bWVkIGJ5IGFwcHMuCiAgIGFuZCBm
cmVlIHJhbWRpc2suCjIuIENvbnZlcnQgcmF3IHBtZW0wIHRvIGRldmRheAogICBuZGN0bCBjcmVh
dGUtbmFtZXNwYWNlIC0tbW9kZSBkZXZkYXggLS1tYXAgbWVtIC1lIG5hbWVzcGFjZTAuMCAtZgoz
LiBIb3RhZGQgdG8gU3lzdGVtIFJBTQogICBlY2hvIGRheDAuMCA+IC9zeXMvYnVzL2RheC9kcml2
ZXJzL2RldmljZV9kYXgvdW5iaW5kCiAgIGVjaG8gZGF4MC4wID4gL3N5cy9idXMvZGF4L2RyaXZl
cnMva21lbS9uZXdfaWQKICAgZWNobyBvbmxpbmVfbW92YWJsZSA+IC9zeXMvZGV2aWNlcy9zeXN0
ZW0vbWVtb3J5WFhYL3N0YXRlCjQuIEJlZm9yZSByZWJvb3QgaG90cmVtb3ZlIGRldmljZS1kYXgg
bWVtb3J5IGZyb20gU3lzdGVtIFJBTQogICBlY2hvIG9mZmxpbmUgPiAvc3lzL2RldmljZXMvc3lz
dGVtL21lbW9yeVhYWC9zdGF0ZQogICBlY2hvIGRheDAuMCA+IC9zeXMvYnVzL2RheC9kcml2ZXJz
L2ttZW0vdW5iaW5kCjUuIENyZWF0ZSByYXcgcG1lbTAgZGV2aWNlCiAgIG5kY3RsIGNyZWF0ZS1u
YW1lc3BhY2UgLS1tb2RlIHJhdyAgLWUgbmFtZXNwYWNlMC4wIC1mCjYuIENvcHkgdGhlIHN0YXRl
IHRoYXQgd2FzIHN0b3JlZCBieSBhcHBzIHRvIHJhbWRpc2sgdG8gcG1lbSBkZXZpY2UKNy4gRG8g
a2V4ZWMgcmVib290IG9yIHJlYm9vdCB0aHJvdWdoIGZpcm13YXJlIGlmIGZpcm13YXJlIGRvZXMg
bm90CiAgIHplcm8gbWVtb3J5IGluIHBtZW0wIHJlZ2lvbiAoVGhlc2UgbWFjaGluZXMgaGF2ZSBv
bmx5IHJlZ3VsYXIKICAgdm9sYXRpbGUgbWVtb3J5KS4gU28gdG8gaGF2ZSBwbWVtMCBkZXZpY2Ug
ZWl0aGVyIG1lbW1hcCBrZXJuZWwKICAgcGFyYW1ldGVyIGlzIHVzZWQsIG9yIGRldmljZXMgbm9k
ZXMgaW4gZHRiIGFyZSBzcGVjaWZpZWQuCgpUaGlzIHBhdGNoIChvZiAzKToKCldoZW4gYWRkX21l
bW9yeSgpIGZhaWxzLCB0aGUgcmVzb3VyY2UgYW5kIHRoZSBtZW1vcnkgc2hvdWxkIGJlIGZyZWVk
LgoKTGluazogaHR0cDovL2xrbWwua2VybmVsLm9yZy9yLzIwMTkwNTE3MjE1NDM4LjY0ODctMi1w
YXNoYS50YXRhc2hpbkBzb2xlZW4uY29tCkZpeGVzOiBjMjIxYzBiMDMwOGYgKCJkZXZpY2UtZGF4
OiAiSG90cGx1ZyIgcGVyc2lzdGVudCBtZW1vcnkgZm9yIHVzZSBsaWtlIG5vcm1hbCBSQU0iKQpT
aWduZWQtb2ZmLWJ5OiBQYXZlbCBUYXRhc2hpbiA8cGFzaGEudGF0YXNoaW5Ac29sZWVuLmNvbT4K
UmV2aWV3ZWQtYnk6IERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBpbnRlbC5jb20+CkNjOiBCam9y
biBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPgpDYzogQm9yaXNsYXYgUGV0a292IDxicEBz
dXNlLmRlPgpDYzogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+CkNjOiBE
YXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPgpDYzogRGF2ZSBKaWFuZyA8
ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+CkNjOiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0
LmNvbT4KQ2M6IEZlbmdndWFuZyBXdSA8ZmVuZ2d1YW5nLnd1QGludGVsLmNvbT4KQ2M6IEh1YW5n
IFlpbmcgPHlpbmcuaHVhbmdAaW50ZWwuY29tPgpDYzogSmFtZXMgTW9ycmlzIDxqbW9ycmlzQG5h
bWVpLm9yZz4KQ2M6IErDqXLDtG1lIEdsaXNzZSA8amdsaXNzZUByZWRoYXQuY29tPgpDYzogS2Vp
dGggQnVzY2ggPGtlaXRoLmJ1c2NoQGludGVsLmNvbT4KQ2M6IE1pY2hhbCBIb2NrbyA8bWhvY2tv
QHN1c2UuY29tPgpDYzogUm9zcyBad2lzbGVyIDx6d2lzbGVyQGtlcm5lbC5vcmc+CkNjOiBTYXNo
YSBMZXZpbiA8c2FzaGFsQGtlcm5lbC5vcmc+CkNjOiBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2Uu
ZGU+CkNjOiBUb20gTGVuZGFja3kgPHRob21hcy5sZW5kYWNreUBhbWQuY29tPgpDYzogVmlzaGFs
IFZlcm1hIDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+CkNjOiBZYW93ZWkgQmFpIDxiYWl5YW93
ZWlAY21zcy5jaGluYW1vYmlsZS5jb20+ClNpZ25lZC1vZmYtYnk6IEFuZHJldyBNb3J0b24gPGFr
cG1AbGludXgtZm91bmRhdGlvbi5vcmc+ClNpZ25lZC1vZmYtYnk6IExpbnVzIFRvcnZhbGRzIDx0
b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4KU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4g
PHNhc2hhbEBrZXJuZWwub3JnPgotLS0KIGRyaXZlcnMvZGF4L2ttZW0uYyB8IDUgKysrKy0KIDEg
ZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2RheC9rbWVtLmMgYi9kcml2ZXJzL2RheC9rbWVtLmMKaW5kZXggYTAyMzE4YzZk
MjhhLi40YzAxMzE4NTcxMzMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZGF4L2ttZW0uYworKysgYi9k
cml2ZXJzL2RheC9rbWVtLmMKQEAgLTY2LDggKzY2LDExIEBAIGludCBkZXZfZGF4X2ttZW1fcHJv
YmUoc3RydWN0IGRldmljZSAqZGV2KQogCW5ld19yZXMtPm5hbWUgPSBkZXZfbmFtZShkZXYpOwog
CiAJcmMgPSBhZGRfbWVtb3J5KG51bWFfbm9kZSwgbmV3X3Jlcy0+c3RhcnQsIHJlc291cmNlX3Np
emUobmV3X3JlcykpOwotCWlmIChyYykKKwlpZiAocmMpIHsKKwkJcmVsZWFzZV9yZXNvdXJjZShu
ZXdfcmVzKTsKKwkJa2ZyZWUobmV3X3Jlcyk7CiAJCXJldHVybiByYzsKKwl9CiAKIAlyZXR1cm4g
MDsKIH0KLS0gCjIuMjAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdApMaW51eC1udmRpbW1AbGlzdHMuMDEu
b3JnCmh0dHBzOi8vbGlzdHMuMDEub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZkaW1tCg==
