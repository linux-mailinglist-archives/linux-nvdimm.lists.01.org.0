Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACADD2626B3
	for <lists+linux-nvdimm@lfdr.de>; Wed,  9 Sep 2020 07:19:07 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C1B3413C85632;
	Tue,  8 Sep 2020 22:19:05 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=jgross@suse.com; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9DAF313C6A141
	for <linux-nvdimm@lists.01.org>; Tue,  8 Sep 2020 22:19:01 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id C8F73ACBA;
	Wed,  9 Sep 2020 05:19:00 +0000 (UTC)
Subject: Re: [PATCH v2 6/7] xen/balloon: try to merge system ram resources
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
References: <20200908201012.44168-1-david@redhat.com>
 <20200908201012.44168-7-david@redhat.com>
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <64d7a2ce-e3b5-3525-d977-76a4bb06e52d@suse.com>
Date: Wed, 9 Sep 2020 07:18:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908201012.44168-7-david@redhat.com>
Content-Language: en-US
Message-ID-Hash: YBX5IONAONZIXQYQ33LUP6F4VIEHBJZJ
X-Message-ID-Hash: YBX5IONAONZIXQYQ33LUP6F4VIEHBJZJ
X-MailFrom: jgross@suse.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <sstabellini@kernel.org>, =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>, Julien Grall <julien@xen.org>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Baoquan He <bhe@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YBX5IONAONZIXQYQ33LUP6F4VIEHBJZJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

T24gMDguMDkuMjAgMjI6MTAsIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOg0KPiBMZXQncyB0cnkg
dG8gbWVyZ2Ugc3lzdGVtIHJhbSByZXNvdXJjZXMgd2UgYWRkLCB0byBtaW5pbWl6ZSB0aGUgbnVt
YmVyDQo+IG9mIHJlc291cmNlcyBpbiAvcHJvYy9pb21lbS4gV2UgZG9uJ3QgY2FyZSBhYm91dCB0
aGUgYm91bmRhcmllcyBvZg0KPiBpbmRpdmlkdWFsIGNodW5rcyB3ZSBhZGRlZC4NCj4gDQo+IENj
OiBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KPiBDYzogTWljaGFs
IEhvY2tvIDxtaG9ja29Ac3VzZS5jb20+DQo+IENjOiBCb3JpcyBPc3Ryb3Zza3kgPGJvcmlzLm9z
dHJvdnNreUBvcmFjbGUuY29tPg0KPiBDYzogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29t
Pg0KPiBDYzogU3RlZmFubyBTdGFiZWxsaW5pIDxzc3RhYmVsbGluaUBrZXJuZWwub3JnPg0KPiBD
YzogUm9nZXIgUGF1IE1vbm7DqSA8cm9nZXIucGF1QGNpdHJpeC5jb20+DQo+IENjOiBKdWxpZW4g
R3JhbGwgPGp1bGllbkB4ZW4ub3JnPg0KPiBDYzogUGFua2FqIEd1cHRhIDxwYW5rYWouZ3VwdGEu
bGludXhAZ21haWwuY29tPg0KPiBDYzogQmFvcXVhbiBIZSA8YmhlQHJlZGhhdC5jb20+DQo+IENj
OiBXZWkgWWFuZyA8cmljaGFyZHcueWFuZ0BsaW51eC5pbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYt
Ynk6IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1ieTog
SnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KDQpKdWVyZ2VuDQoNCj4gLS0tDQo+ICAg
ZHJpdmVycy94ZW4vYmFsbG9vbi5jIHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVuL2Jh
bGxvb24uYyBiL2RyaXZlcnMveGVuL2JhbGxvb24uYw0KPiBpbmRleCA3YmFjMzg3NjQ1MTNkLi5i
NTdiMjA2N2VjYmZiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3hlbi9iYWxsb29uLmMNCj4gKysr
IGIvZHJpdmVycy94ZW4vYmFsbG9vbi5jDQo+IEBAIC0zMzEsNyArMzMxLDcgQEAgc3RhdGljIGVu
dW0gYnBfc3RhdGUgcmVzZXJ2ZV9hZGRpdGlvbmFsX21lbW9yeSh2b2lkKQ0KPiAgIAltdXRleF91
bmxvY2soJmJhbGxvb25fbXV0ZXgpOw0KPiAgIAkvKiBhZGRfbWVtb3J5X3Jlc291cmNlKCkgcmVx
dWlyZXMgdGhlIGRldmljZV9ob3RwbHVnIGxvY2sgKi8NCj4gICAJbG9ja19kZXZpY2VfaG90cGx1
ZygpOw0KPiAtCXJjID0gYWRkX21lbW9yeV9yZXNvdXJjZShuaWQsIHJlc291cmNlLCAwKTsNCj4g
KwlyYyA9IGFkZF9tZW1vcnlfcmVzb3VyY2UobmlkLCByZXNvdXJjZSwgTUVNSFBfTUVSR0VfUkVT
T1VSQ0UpOw0KPiAgIAl1bmxvY2tfZGV2aWNlX2hvdHBsdWcoKTsNCj4gICAJbXV0ZXhfbG9jaygm
YmFsbG9vbl9tdXRleCk7DQo+ICAgDQo+IA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRp
bW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZk
aW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
