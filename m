Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F8520EB0A
	for <lists+linux-nvdimm@lfdr.de>; Tue, 30 Jun 2020 03:50:32 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 55F0D111FF49A;
	Mon, 29 Jun 2020 18:50:30 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EB696111FF496
	for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 18:50:27 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e22so14673926edq.8
        for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 18:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5mHuFzQWqAIpV/bjOd1ZMX2Wff0T7CDiptOBml+k1GE=;
        b=Q6HUbLeD2nj68waH+I829FEwmBauUjApbkuAtpy2+N8XAn4Ecs/klCe4ZIlgnHzlye
         fi9L67z0o+Q9hUODw7rLppvbe2fxSgdIOm2gls82YUn8P5PqNTmAxYpEkHVBSEmhchI/
         aaNgVekUA0qSWdSB5qhGKeL8QcThtiyOhvGqejQhuozVCBRR0fs0eY6rE97ElNnFBwTp
         3q6ngXEjbwkbjeM7emxYfDyhEyEdYOEdnoApb1fV91V3tvxj/shXdPJbTs7J6LGNFZw2
         5H24TjuCyAqCaoUsqY0nmjf6zKtu7lN/I0/K0LTTg/JvO/LQT6D04hRkK9bF9hgf2aNd
         FBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5mHuFzQWqAIpV/bjOd1ZMX2Wff0T7CDiptOBml+k1GE=;
        b=JZe9+046tNb1/jZ0WrBQHfqJEK8vdbgDdul1KONToUA4sZZyt2kIhcGsLVWwsU03D/
         DS67+kM3J06SIFjHv6camz5d9pgLob8FtI8bpWEdgVnW9NFtVurpyQlU5V03SlOlNGAF
         BnGMHTvYCOqho9UnMja3BWGCVtNqD9DvtahRcXfgUaezsIlz8mVHl11krnekWizyecQC
         m4NN9AAA843vyPMrwLHh4sORC3VuT5Tm4aqNAeBVdO9RYNdnfPMq/sNsYGz0S2MTLcuO
         DqBesYLtBzllyfR84sdKdg0xOvTCXdl5yoiFQA/6xz74cJIVhxcmC2dQ+MJ8rCc9ZEOp
         fPzw==
X-Gm-Message-State: AOAM533BFXEMUv/o9OqMVAUCntfe5ZtS0NbbrmJ0H6J4WAhcg6qZsgU0
	mfO3fnhikxGHFJX3l9ev/je/gqpaohYbOEAcQBobKw==
X-Google-Smtp-Source: ABdhPJyVCpe7LHuMA+1UB9Rfm8NoLpv7tbHYkZ5fYWCXJix1alZTf43Uugpm1DJXymhoSuwVabQ+k/mXHClWOIU4nPU=
X-Received: by 2002:a05:6402:b79:: with SMTP id cb25mr1255706edb.154.1593481826315;
 Mon, 29 Jun 2020 18:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200629135722.73558-1-aneesh.kumar@linux.ibm.com>
 <20200629135722.73558-7-aneesh.kumar@linux.ibm.com> <20200629160940.GU21462@kitsune.suse.cz>
 <87lfk5hahc.fsf@linux.ibm.com>
In-Reply-To: <87lfk5hahc.fsf@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 29 Jun 2020 18:50:15 -0700
Message-ID: <CAPcyv4hEV=Ps=t=3qsFq3Ob1jzf=ptoZmYTDkgr8D_G0op8uvQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] powerpc/pmem: Avoid the barrier in flush routines
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: PF5IFJCGEES6Z7APJWHJBEO4SRAN47NB
X-Message-ID-Hash: PF5IFJCGEES6Z7APJWHJBEO4SRAN47NB
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>, Jan Kara <jack@suse.cz>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PF5IFJCGEES6Z7APJWHJBEO4SRAN47NB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gTW9uLCBKdW4gMjksIDIwMjAgYXQgMTo0MSBQTSBBbmVlc2ggS3VtYXIgSy5WDQo8YW5lZXNo
Lmt1bWFyQGxpbnV4LmlibS5jb20+IHdyb3RlOg0KPg0KPiBNaWNoYWwgU3VjaMOhbmVrIDxtc3Vj
aGFuZWtAc3VzZS5kZT4gd3JpdGVzOg0KPg0KPiA+IEhlbGxvLA0KPiA+DQo+ID4gT24gTW9uLCBK
dW4gMjksIDIwMjAgYXQgMDc6Mjc6MjBQTSArMDUzMCwgQW5lZXNoIEt1bWFyIEsuViB3cm90ZToN
Cj4gPj4gbnZkaW1tIGV4cGVjdCB0aGUgZmx1c2ggcm91dGluZXMgdG8ganVzdCBtYXJrIHRoZSBj
YWNoZSBjbGVhbi4gVGhlIGJhcnJpZXINCj4gPj4gdGhhdCBtYXJrIHRoZSBzdG9yZSBnbG9iYWxs
eSB2aXNpYmxlIGlzIGRvbmUgaW4gbnZkaW1tX2ZsdXNoKCkuDQo+ID4+DQo+ID4+IFVwZGF0ZSB0
aGUgcGFwcl9zY20gZHJpdmVyIHRvIGEgc2ltcGxpZmllZCBudmRpbV9mbHVzaCBjYWxsYmFjayB0
aGF0IGRvDQo+ID4+IG9ubHkgdGhlIHJlcXVpcmVkIGJhcnJpZXIuDQo+ID4+DQo+ID4+IFNpZ25l
ZC1vZmYtYnk6IEFuZWVzaCBLdW1hciBLLlYgPGFuZWVzaC5rdW1hckBsaW51eC5pYm0uY29tPg0K
PiA+PiAtLS0NCj4gPj4gIGFyY2gvcG93ZXJwYy9saWIvcG1lbS5jICAgICAgICAgICAgICAgICAg
IHwgIDYgLS0tLS0tDQo+ID4+ICBhcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3BzZXJpZXMvcGFwcl9z
Y20uYyB8IDEzICsrKysrKysrKysrKysNCj4gPj4gIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0
aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2FyY2gvcG93
ZXJwYy9saWIvcG1lbS5jIGIvYXJjaC9wb3dlcnBjL2xpYi9wbWVtLmMNCj4gPj4gaW5kZXggNWE2
MWFhZWI2OTMwLi4yMTIxMGZhNjc2ZTUgMTAwNjQ0DQo+ID4+IC0tLSBhL2FyY2gvcG93ZXJwYy9s
aWIvcG1lbS5jDQo+ID4+ICsrKyBiL2FyY2gvcG93ZXJwYy9saWIvcG1lbS5jDQo+ID4+IEBAIC0x
OSw5ICsxOSw2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBfX2NsZWFuX3BtZW1fcmFuZ2UodW5zaWdu
ZWQgbG9uZyBzdGFydCwgdW5zaWduZWQgbG9uZyBzdG9wKQ0KPiA+Pg0KPiA+PiAgICAgIGZvciAo
aSA9IDA7IGkgPCBzaXplID4+IHNoaWZ0OyBpKyssIGFkZHIgKz0gYnl0ZXMpDQo+ID4+ICAgICAg
ICAgICAgICBhc20gdm9sYXRpbGUoUFBDX0RDQlNUUFMoJTAsICUxKTogOiJpIigwKSwgInIiKGFk
ZHIpOiAibWVtb3J5Iik7DQo+ID4+IC0NCj4gPj4gLQ0KPiA+PiAtICAgIGFzbSB2b2xhdGlsZShQ
UENfUEhXU1lOQyA6OjogIm1lbW9yeSIpOw0KPiA+PiAgfQ0KPiA+Pg0KPiA+PiAgc3RhdGljIGlu
bGluZSB2b2lkIF9fZmx1c2hfcG1lbV9yYW5nZSh1bnNpZ25lZCBsb25nIHN0YXJ0LCB1bnNpZ25l
ZCBsb25nIHN0b3ApDQo+ID4+IEBAIC0zNCw5ICszMSw2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBf
X2ZsdXNoX3BtZW1fcmFuZ2UodW5zaWduZWQgbG9uZyBzdGFydCwgdW5zaWduZWQgbG9uZyBzdG9w
KQ0KPiA+Pg0KPiA+PiAgICAgIGZvciAoaSA9IDA7IGkgPCBzaXplID4+IHNoaWZ0OyBpKyssIGFk
ZHIgKz0gYnl0ZXMpDQo+ID4+ICAgICAgICAgICAgICBhc20gdm9sYXRpbGUoUFBDX0RDQkZQUygl
MCwgJTEpOiA6ImkiKDApLCAiciIoYWRkcik6ICJtZW1vcnkiKTsNCj4gPj4gLQ0KPiA+PiAtDQo+
ID4+IC0gICAgYXNtIHZvbGF0aWxlKFBQQ19QSFdTWU5DIDo6OiAibWVtb3J5Iik7DQo+ID4+ICB9
DQo+ID4+DQo+ID4+ICBzdGF0aWMgaW5saW5lIHZvaWQgY2xlYW5fcG1lbV9yYW5nZSh1bnNpZ25l
ZCBsb25nIHN0YXJ0LCB1bnNpZ25lZCBsb25nIHN0b3ApDQo+ID4+IGRpZmYgLS1naXQgYS9hcmNo
L3Bvd2VycGMvcGxhdGZvcm1zL3BzZXJpZXMvcGFwcl9zY20uYyBiL2FyY2gvcG93ZXJwYy9wbGF0
Zm9ybXMvcHNlcmllcy9wYXByX3NjbS5jDQo+ID4+IGluZGV4IDljNTY5MDc4YTA5Zi4uOWE5YTA3
NjZmOGI2IDEwMDY0NA0KPiA+PiAtLS0gYS9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3BzZXJpZXMv
cGFwcl9zY20uYw0KPiA+PiArKysgYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3BzZXJpZXMvcGFw
cl9zY20uYw0KPiA+PiBAQCAtNjMwLDYgKzYzMCwxOCBAQCBzdGF0aWMgaW50IHBhcHJfc2NtX25k
Y3RsKHN0cnVjdCBudmRpbW1fYnVzX2Rlc2NyaXB0b3IgKm5kX2Rlc2MsDQo+ID4+DQo+ID4+ICAg
ICAgcmV0dXJuIDA7DQo+ID4+ICB9DQo+ID4+ICsvKg0KPiA+PiArICogV2UgaGF2ZSBtYWRlIHN1
cmUgdGhlIHBtZW0gd3JpdGVzIGFyZSBkb25lIHN1Y2ggdGhhdCBiZWZvcmUgY2FsbGluZyB0aGlz
DQo+ID4+ICsgKiBhbGwgdGhlIGNhY2hlcyBhcmUgZmx1c2hlZC9jbGVhbi4gV2UgdXNlIGRjYmYv
ZGNiZnBzIHRvIGVuc3VyZSB0aGlzLiBIZXJlDQo+ID4+ICsgKiB3ZSBqdXN0IG5lZWQgdG8gYWRk
IHRoZSBuZWNlc3NhcnkgYmFycmllciB0byBtYWtlIHN1cmUgdGhlIGFib3ZlIGZsdXNoZXMNCj4g
Pj4gKyAqIGFyZSBoYXZlIHVwZGF0ZWQgcGVyc2lzdGVudCBzdG9yYWdlIGJlZm9yZSBhbnkgZGF0
YSBhY2Nlc3Mgb3IgZGF0YSB0cmFuc2Zlcg0KPiA+PiArICogY2F1c2VkIGJ5IHN1YnNlcXVlbnQg
aW5zdHJ1Y3Rpb25zIGlzIGluaXRpYXRlZC4NCj4gPj4gKyAqLw0KPiA+PiArc3RhdGljIGludCBw
YXByX3NjbV9mbHVzaF9zeW5jKHN0cnVjdCBuZF9yZWdpb24gKm5kX3JlZ2lvbiwgc3RydWN0IGJp
byAqYmlvKQ0KPiA+PiArew0KPiA+PiArICAgIGFyY2hfcG1lbV9mbHVzaF9iYXJyaWVyKCk7DQo+
ID4+ICsgICAgcmV0dXJuIDA7DQo+ID4+ICt9DQo+ID4+DQo+ID4+ICBzdGF0aWMgc3NpemVfdCBm
bGFnc19zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPj4gICAgICAgICAgICAgICAgICAgICAg
ICBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKQ0KPiA+PiBAQCAtNzQz
LDYgKzc1NSw3IEBAIHN0YXRpYyBpbnQgcGFwcl9zY21fbnZkaW1tX2luaXQoc3RydWN0IHBhcHJf
c2NtX3ByaXYgKnApDQo+ID4+ICAgICAgbmRyX2Rlc2MubWFwcGluZyA9ICZtYXBwaW5nOw0KPiA+
PiAgICAgIG5kcl9kZXNjLm51bV9tYXBwaW5ncyA9IDE7DQo+ID4+ICAgICAgbmRyX2Rlc2MubmRf
c2V0ID0gJnAtPm5kX3NldDsNCj4gPj4gKyAgICBuZHJfZGVzYy5mbHVzaCA9IHBhcHJfc2NtX2Zs
dXNoX3N5bmM7DQo+ID4NCj4gPiBBRkFJQ1QgY3VycmVudGx5IHRoZSBvbmx5IGRldmljZSB0aGF0
IGltcGxlbWVudHMgZmx1c2ggaXMgdmlydGlvX3BtZW0uDQo+ID4gSG93IGRvZXMgdGhlIG5maXQg
ZHJpdmVyIGdldCBhd2F5IHdpdGhvdXQgaW1wbGVtZW50aW5nIGZsdXNoPw0KPg0KPiBnZW5lcmlj
X252ZGltbV9mbHVzaCBkb2VzIHRoZSByZXF1aXJlZCBiYXJyaWVyIGZvciBuZml0LiBUaGUgcmVh
c29uIGZvcg0KPiBhZGRpbmcgbmRyX2Rlc2MuZmx1c2ggY2FsbCBiYWNrIGZvciBwYXByX3NjbSB3
YXMgdG8gYXZvaWQgdGhlIHVzYWdlDQo+IG9mIGlvbWVtIGJhc2VkIGRlZXAgZmx1c2hpbmcgKG5k
cl9yZWdpb25fZGF0YS5mbHVzaF93cHEpIHdoaWNoIGlzIG5vdA0KPiBzdXBwb3J0ZWQgYnkgcGFw
cl9zY20uDQo+DQo+IEJUVyB3ZSBkbyByZXR1cm4gTlVMTCBmb3IgbmRyZF9nZXRfZmx1c2hfd3Bx
KCkgb24gcG93ZXIuIFNvIHRoZSB1cHN0cmVhbQ0KPiBjb2RlIGFsc28gZG9lcyB0aGUgc2FtZSB0
aGluZywgYnV0IGluIGEgZGlmZmVyZW50IHdheS4NCj4NCj4NCj4gPiBBbHNvIHRoZSBmbHVzaCB0
YWtlcyBhcmd1bWVudHMgdGhhdCBhcmUgY29tcGxldGVseSB1bnVzZWQgYnV0IGEgdXNlciBvZg0K
PiA+IHRoZSBwbWVtIHJlZ2lvbiBtdXN0IGFzc3VtZSB0aGV5IGFyZSB1c2VkLCBhbmQgY2FsbCBm
bHVzaCgpIG9uIHRoZQ0KPiA+IHJlZ2lvbiByYXRoZXIgdGhhbiBhcmNoX3BtZW1fZmx1c2hfYmFy
cmllcigpIGRpcmVjdGx5Lg0KPg0KPiBUaGUgYmlvIGFyZ3VtZW50IGNhbiBoZWxwIGEgcG1lbSBk
cml2ZXIgdG8gZG8gcmFuZ2UgYmFzZWQgZmx1c2hpbmcgaW4NCj4gY2FzZSBvZiBwbWVtX21ha2Vf
cmVxdWVzdC4gSWYgYmlvIGlzIG51bGwgdGhlbiB3ZSBtdXN0IGFzc3VtZSBhIGZ1bGwNCj4gZGV2
aWNlIGZsdXNoLg0KDQpUaGUgYmlvIGFyZ3VtZW50IGlzbid0IGZvciByYW5nZSBiYXNlZCBmbHVz
aGluZywgaXQgaXMgZm9yIGZsdXNoDQpvcGVyYXRpb25zIHRoYXQgbmVlZCB0byBjb21wbGV0ZSBh
c3luY2hyb25vdXNseS4NCg0KVGhlcmUncyBubyBtZWNoYW5pc20gZm9yIHRoZSBibG9jayBsYXll
ciB0byBjb21tdW5pY2F0ZSByYW5nZSBiYXNlZA0KY2FjaGUgZmx1c2hpbmcsIGJsb2NrLWRldmlj
ZSBmbHVzaGluZyBpcyBhc3N1bWVkIHRvIGJlIHRoZSBkZXZpY2Uncw0KZW50aXJlIGNhY2hlLiBG
b3IgcG1lbSB0aGF0IHdvdWxkIGJlIHRoZSBlbnRpcmV0eSBvZiB0aGUgY3B1IGNhY2hlLg0KSW5z
dGVhZCBvZiBtb2RlbGluZyB0aGUgY3B1IGNhY2hlIGFzIGEgc3RvcmFnZSBkZXZpY2UgY2FjaGUg
aXQgaXMNCm1vZGVsZWQgYXMgcGFnZS1jYWNoZS4gT25jZSB0aGUgZnMtbGF5ZXIgd3JpdGVzIGJh
Y2sgcGFnZS1jYWNoZSAvDQpjcHUtY2FjaGUgdGhlIHN0b3JhZ2UgZGV2aWNlIGlzIG9ubHkgcmVz
cG9uc2libGUgZm9yIGZsdXNoaW5nIHRob3NlDQpjYWNoZS13cml0ZXMgaW50byB0aGUgcGVyc2lz
dGVuY2UgZG9tYWluLg0KDQpBZGRpdGlvbmFsbHkgdGhlcmUgaXMgYSBjb25jZXB0IG9mIGRlZXAt
Zmx1c2ggdGhhdCByZWxlZ2F0ZXMgc29tZQ0KcG93ZXItZmFpbCBzY2VuYXJpb3MgdG8gYSBzbWFs
bGVyIGZhaWx1cmUgZG9tYWluLiBGb3IgZXhhbXBsZSBjb25zaWRlcg0KdGhlIGRpZmZlcmVuY2Ug
YmV0d2VlbiBhIHdyaXRlIGFycml2aW5nIGF0IHRoZSBoZWFkIG9mIGEgZGV2aWNlLXF1ZXVlDQph
bmQgc3VjY2Vzc2Z1bGx5IHRyYXZlcnNpbmcgYSBkZXZpY2UtcXVldWUgdG8gbWVkaWEuIFRoZSBl
eHBlY3RhdGlvbg0Kb2YgcG1lbSBhcHBsaWNhdGlvbnMgaXMgdGhhdCBkYXRhIGlzIHBlcnNpc3Rl
ZCBvbmNlIHRoZXkgcmVhY2ggdGhlDQplcXVpdmFsZW50IG9mIHRoZSB4ODYgQURSIGRvbWFpbiwg
ZGVlcC1mbHVzaCBpcyBwYXN0IEFEUi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1A
bGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1t
LWxlYXZlQGxpc3RzLjAxLm9yZwo=
