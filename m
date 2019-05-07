Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE49516E03
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 May 2019 02:09:51 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CADF621243BD3;
	Tue,  7 May 2019 17:09:49 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E57DC211F9D7B
 for <linux-nvdimm@lists.01.org>; Tue,  7 May 2019 17:09:47 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 May 2019 17:09:45 -0700
X-ExtLoop1: 1
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by fmsmga004.fm.intel.com with ESMTP; 07 May 2019 17:09:46 -0700
Subject: [PATCH v2 0/6] mm/devm_memremap_pages: Fix page release race
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Tue, 07 May 2019 16:55:59 -0700
Message-ID: <155727335978.292046.12068191395005445711.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
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
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Q2hhbmdlcyBzaW5jZSB2MSBbMV06Ci0gRml4IGEgTlVMTC1wb2ludGVyIGRlcmVmIGNyYXNoIGlu
IHBjaV9wMnBkbWFfcmVsZWFzZSgpIChMb2dhbikKCi0gUmVmcmVzaCB0aGUgcDJwZG1hIHBhdGNo
IGhlYWRlcnMgdG8gbWF0Y2ggdGhlIGZvcm1hdCBvZiBvdGhlciBwMnBkbWEKICBwYXRjaGVzIChC
am9ybikKCi0gQ29sbGVjdCBJcmEncyByZXZpZXdlZC1ieQoKWzFdOiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9sa21sLzE1NTM4NzMyNDM3MC4yNDQzODQxLjU3NDcxNTc0NTI2MjYyODgzNy5zdGdp
dEBkd2lsbGlhMi1kZXNrMy5hbXIuY29ycC5pbnRlbC5jb20vCgotLS0KCkxvZ2FuIGF1ZGl0ZWQg
dGhlIGRldm1fbWVtcmVtYXBfcGFnZXMoKSBzaHV0ZG93biBwYXRoIGFuZCBub3RpY2VkIHRoYXQK
aXQgd2FzIHBvc3NpYmxlIHRvIHByb2NlZWQgdG8gYXJjaF9yZW1vdmVfbWVtb3J5KCkgYmVmb3Jl
IGFsbApwb3RlbnRpYWwgcGFnZSByZWZlcmVuY2VzIGhhdmUgYmVlbiByZWFwZWQuCgpJbnRyb2R1
Y2UgYSBuZXcgLT5jbGVhbnVwKCkgY2FsbGJhY2sgdG8gZG8gdGhlIHdvcmsgb2Ygd2FpdGluZyBm
b3IgYW55CnN0cmFnZ2xpbmcgcGFnZSByZWZlcmVuY2VzIGFuZCB0aGVuIHBlcmZvcm0gdGhlIHBl
cmNwdV9yZWZfZXhpdCgpIGluCmRldm1fbWVtcmVtYXBfcGFnZXNfcmVsZWFzZSgpIGNvbnRleHQu
CgpGb3IgcDJwZG1hIHRoaXMgaW52b2x2ZXMgc29tZSBkZWVwZXIgcmV3b3JrcyB0byByZWZlcmVu
Y2UgY291bnQKcmVzb3VyY2VzIG9uIGEgcGVyLWluc3RhbmNlIGJhc2lzIHJhdGhlciB0aGFuIGEg
cGVyIHBjaS1kZXZpY2UgYmFzaXMuIEEKbW9kaWZpZWQgZ2VuYWxsb2MgYXBpIGlzIGludHJvZHVj
ZWQgdG8gY29udmV5IGEgZHJpdmVyLXByaXZhdGUgcG9pbnRlcgp0aHJvdWdoIGdlbl9wb29sX3th
bGxvYyxmcmVlfSgpIGludGVyZmFjZXMuIEFsc28sIGEKZGV2bV9tZW11bm1hcF9wYWdlcygpIGFw
aSBpcyBpbnRyb2R1Y2VkIHNpbmNlIHAycGRtYSBkb2VzIG5vdAphdXRvLXJlbGVhc2UgcmVzb3Vy
Y2VzIG9uIGEgc2V0dXAgZmFpbHVyZS4KClRoZSBkYXggYW5kIHBtZW0gY2hhbmdlcyBwYXNzIHRo
ZSBudmRpbW0gdW5pdCB0ZXN0cywgYW5kIHRoZSBwMnBkbWEKY2hhbmdlcyBzaG91bGQgbm93IHBh
c3MgdGVzdGluZyB3aXRoIHRoZSBwY2lfcDJwZG1hX3JlbGVhc2UoKSBmaXguCkrDqXLDtG1lLCBo
b3cgZG9lcyB0aGlzIGxvb2sgZm9yIEhNTT8KCkluIGdlbmVyYWwsIEkgdGhpbmsgdGhlc2UgcGF0
Y2hlcyAvIGZpeGVzIGFyZSBzdWl0YWJsZSBmb3IgdjUuMi1yYzEgb3IKdjUuMi1yYzIsIGFuZCBz
aW5jZSB0aGV5IHRvdWNoIGtlcm5lbC9tZW1yZW1hcC5jLCBhbmQgb3RoZXIgdmFyaW91cwpwaWVj
ZXMgb2YgdGhlIGNvcmUsIHRoZXkgc2hvdWxkIGdvIHRocm91Z2ggdGhlIC1tbSB0cmVlLiBUaGVz
ZSBwYXRjaGVzCm1lcmdlIGNsZWFubHkgd2l0aCB0aGUgY3VycmVudCBzdGF0ZSBvZiAtbmV4dCwg
cGFzcyB0aGUgbnZkaW1tIHVuaXQKdGVzdHMsIGFuZCBhcmUgZXhwb3NlZCB0byB0aGUgMGRheSBy
b2JvdCB3aXRoIG5vIGlzc3VlcyByZXBvcnRlZAooaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvZGpidy9udmRpbW0uZ2l0L2xvZy8/aD1saWJudmRpbW0tcGVu
ZGluZykuCgotLS0KCkRhbiBXaWxsaWFtcyAoNik6CiAgICAgIGRyaXZlcnMvYmFzZS9kZXZyZXM6
IEludHJvZHVjZSBkZXZtX3JlbGVhc2VfYWN0aW9uKCkKICAgICAgbW0vZGV2bV9tZW1yZW1hcF9w
YWdlczogSW50cm9kdWNlIGRldm1fbWVtdW5tYXBfcGFnZXMKICAgICAgUENJL1AyUERNQTogRml4
IHRoZSBnZW5fcG9vbF9hZGRfdmlydCgpIGZhaWx1cmUgcGF0aAogICAgICBsaWIvZ2VuYWxsb2M6
IEludHJvZHVjZSBjaHVuayBvd25lcnMKICAgICAgUENJL1AyUERNQTogVHJhY2sgcGdtYXAgcmVm
ZXJlbmNlcyBwZXIgcmVzb3VyY2UsIG5vdCBnbG9iYWxseQogICAgICBtbS9kZXZtX21lbXJlbWFw
X3BhZ2VzOiBGaXggZmluYWwgcGFnZSBwdXQgcmFjZQoKCiBkcml2ZXJzL2Jhc2UvZGV2cmVzLmMg
ICAgICAgICAgICAgfCAgIDI0ICsrKysrKystCiBkcml2ZXJzL2RheC9kZXZpY2UuYyAgICAgICAg
ICAgICAgfCAgIDEzICstLS0KIGRyaXZlcnMvbnZkaW1tL3BtZW0uYyAgICAgICAgICAgICB8ICAg
MTcgKysrKy0KIGRyaXZlcnMvcGNpL3AycGRtYS5jICAgICAgICAgICAgICB8ICAxMTUgKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQogaW5jbHVkZS9saW51eC9kZXZpY2UuaCAg
ICAgICAgICAgIHwgICAgMSAKIGluY2x1ZGUvbGludXgvZ2VuYWxsb2MuaCAgICAgICAgICB8ICAg
NTUgKysrKysrKysrKysrKysrKy0tCiBpbmNsdWRlL2xpbnV4L21lbXJlbWFwLmggICAgICAgICAg
fCAgICA4ICsrKwoga2VybmVsL21lbXJlbWFwLmMgICAgICAgICAgICAgICAgIHwgICAyMyArKysr
KystCiBsaWIvZ2VuYWxsb2MuYyAgICAgICAgICAgICAgICAgICAgfCAgIDUxICsrKysrKysrLS0t
LS0tLS0KIG1tL2htbS5jICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMTQgKy0tLS0KIHRv
b2xzL3Rlc3RpbmcvbnZkaW1tL3Rlc3QvaW9tYXAuYyB8ICAgIDIgKwogMTEgZmlsZXMgY2hhbmdl
ZCwgMjE3IGluc2VydGlvbnMoKyksIDEwNiBkZWxldGlvbnMoLSkKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdApM
aW51eC1udmRpbW1AbGlzdHMuMDEub3JnCmh0dHBzOi8vbGlzdHMuMDEub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtbnZkaW1tCg==
