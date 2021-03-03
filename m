Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB6832B5E6
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Mar 2021 09:20:26 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A6E0F100EB84B;
	Wed,  3 Mar 2021 00:20:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=hare@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 08D6C100EBBCD
	for <linux-nvdimm@lists.01.org>; Wed,  3 Mar 2021 00:20:19 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 2075AAD57;
	Wed,  3 Mar 2021 08:20:18 +0000 (UTC)
Subject: Re: [RFC PATCH v1 1/6] badblocks: add more helper structure and
 routines in badblocks.h
To: Coly Li <colyli@suse.de>, linux-block@vger.kernel.org, axboe@kernel.dk,
 dan.j.williams@intel.com, vishal.l.verma@intel.com, neilb@suse.de
References: <20210302040252.103720-1-colyli@suse.de>
 <20210302040252.103720-2-colyli@suse.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <96a899a9-151e-ff8c-c61c-900df1122357@suse.de>
Date: Wed, 3 Mar 2021 09:20:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210302040252.103720-2-colyli@suse.de>
Content-Language: en-US
Message-ID-Hash: WU7AWXI7U2FDOCP67SEJSISPMD56NYMY
X-Message-ID-Hash: WU7AWXI7U2FDOCP67SEJSISPMD56NYMY
X-MailFrom: hare@suse.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: antlists@youngman.org.uk, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WU7AWXI7U2FDOCP67SEJSISPMD56NYMY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gMy8yLzIxIDU6MDIgQU0sIENvbHkgTGkgd3JvdGU6DQo+IFRoaXMgcGF0Y2ggYWRkcyB0aGUg
Zm9sbG93aW5nIGhlbHBlciBzdHJ1Y3R1cmUgYW5kIHJvdXRpbmVzIGludG8NCj4gYmFkYmxvY2tz
LmgsDQo+IC0gc3RydWN0IGJhZF9jb250ZXh0DQo+ICAgVGhpcyBzdHJ1Y3R1cmUgaXMgdXNlZCBp
biBpbXByb3ZlZCBiYWRibG9ja3MgY29kZSBmb3IgYmFkIHRhYmxlDQo+ICAgaXRlcmF0aW9uLg0K
PiAtIEJCX0VORCgpDQo+ICAgVGhlIG1hY3JvIHRvIGN1bGN1bGF0ZSBlbmQgTEJBIG9mIGEgYmFk
IHJhbmdlIHJlY29yZCBmcm9tIGJhZA0KPiAgIHRhYmxlLg0KPiAtIGJhZGJsb2Nrc19mdWxsKCkg
YW5kIGJhZGJsb2Nrc19lbXB0eSgpDQo+ICAgVGhlIGlubGluZSByb3V0aW5lcyB0byBjaGVjayB3
aGV0aGVyIGJhZCB0YWJsZSBpcyBmdWxsIG9yIGVtcHR5Lg0KPiAtIHNldF9jaGFuZ2VkKCkgYW5k
IGNsZWFyX2NoYW5nZWQoKQ0KPiAgIFRoZSBpbmxpbmUgcm91dGluZXMgdG8gc2V0IGFuZCBjbGVh
ciAnY2hhbmdlZCcgdGFnIGZyb20gc3RydWN0DQo+ICAgYmFkYmxvY2tzLg0KPiANCj4gVGhlc2Ug
bmV3IGhlbHBlciBzdHJ1Y3R1cmUgYW5kIHJvdXRpbmVzIGNhbiBoZWxwIHRvIG1ha2UgdGhlIGNv
ZGUgbW9yZQ0KPiBjbGVhciwgdGhleSB3aWxsIGJlIHVzZWQgaW4gdGhlIGltcHJvdmVkIGJhZGJs
b2NrcyBjb2RlIGluIGZvbGxvd2luZw0KPiBwYXRjaGVzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
Q29seSBMaSA8Y29seWxpQHN1c2UuZGU+DQo+IC0tLQ0KPiAgaW5jbHVkZS9saW51eC9iYWRibG9j
a3MuaCB8IDMyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMzIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
YmFkYmxvY2tzLmggYi9pbmNsdWRlL2xpbnV4L2JhZGJsb2Nrcy5oDQo+IGluZGV4IDI0MjYyNzZi
OWJkMy4uMTY2MTYxODQyZDFmIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2JhZGJsb2Nr
cy5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvYmFkYmxvY2tzLmgNCj4gQEAgLTE1LDYgKzE1LDcg
QEANCj4gICNkZWZpbmUgQkJfT0ZGU0VUKHgpCSgoKHgpICYgQkJfT0ZGU0VUX01BU0spID4+IDkp
DQo+ICAjZGVmaW5lIEJCX0xFTih4KQkoKCh4KSAmIEJCX0xFTl9NQVNLKSArIDEpDQo+ICAjZGVm
aW5lIEJCX0FDSyh4KQkoISEoKHgpICYgQkJfQUNLX01BU0spKQ0KPiArI2RlZmluZSBCQl9FTkQo
eCkJKEJCX09GRlNFVCh4KSArIEJCX0xFTih4KSkNCj4gICNkZWZpbmUgQkJfTUFLRShhLCBsLCBh
Y2spICgoKGEpPDw5KSB8ICgobCktMSkgfCAoKHU2NCkoISEoYWNrKSkgPDwgNjMpKQ0KPiAgDQo+
ICAvKiBCYWQgYmxvY2sgbnVtYmVycyBhcmUgc3RvcmVkIHNvcnRlZCBpbiBhIHNpbmdsZSBwYWdl
Lg0KPiBAQCAtNDEsNiArNDIsMTQgQEAgc3RydWN0IGJhZGJsb2NrcyB7DQo+ICAJc2VjdG9yX3Qg
c2l6ZTsJCS8qIGluIHNlY3RvcnMgKi8NCj4gIH07DQo+ICANCj4gK3N0cnVjdCBiYWRfY29udGV4
dCB7DQo+ICsJc2VjdG9yX3QJc3RhcnQ7DQo+ICsJc2VjdG9yX3QJbGVuOw0KPiArCWludAkJYWNr
Ow0KPiArCXNlY3Rvcl90CW9yaWdfc3RhcnQ7DQo+ICsJc2VjdG9yX3QJb3JpZ19sZW47DQo+ICt9
Ow0KPiArDQpNYXliZSByZW5hbWUgaXQgdG8gJ2JhZGJsb2Nrc19jb250ZXh0Jy4NCkl0J3Mgbm90
IHRoZSBjb250ZXh0IHdoaWNoIGlzIGJhZCAuLi4NCg0KQ2hlZXJzLA0KDQpIYW5uZXMNCi0tIA0K
RHIuIEhhbm5lcyBSZWluZWNrZQkJICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QN
CmhhcmVAc3VzZS5kZQkJCSAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4DQpTVVNF
IFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7D
vHJuYmVyZw0KSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHRjogRmVsaXggSW1lbmTDtnJmZmVy
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52
ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNj
cmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
