Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8350C144032
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 Jan 2020 16:10:42 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 266D21007B8D5;
	Tue, 21 Jan 2020 07:13:59 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=pbonzini@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C2EEC10113666
	for <linux-nvdimm@lists.01.org>; Tue, 21 Jan 2020 07:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1579619437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l3UImGOzBXgoozBAyoISgB2Kd4SVsoekGjPkkvWBCTg=;
	b=Fd5MUqGUqGT1KWqjYtLkjt4AhfFcmbjSEYU7cu0RNPlnBnT3zWMYc2PKhWAvV0jcpS7IyK
	BLsu1++CLtmGifPtRuKNOMgKJgN0k0bKUhR96aTA45a3XNJ5iD5ESk/ZIBd2wypKLglew5
	EpvNgGGkNiv7auGL0YmqcHmIk/cHLTQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-jvgGwqlAPf6QctkMsekoDw-1; Tue, 21 Jan 2020 10:10:34 -0500
Received: by mail-wr1-f70.google.com with SMTP id c17so1433740wrp.10
        for <linux-nvdimm@lists.01.org>; Tue, 21 Jan 2020 07:10:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dLNqv137Ty3zBX/5Bsp+2Ypr44jpbB2i9ogizbwLSF8=;
        b=E3XN1jEZnYlFMxWwAaTK8M98oc4LPL1EJEVKeBit926PQuD4xbtX0eAhAFfR9K3xqK
         A8ydxJAvB2RMAfgTzKsd27QfFkoAPXIfQjbaRhd6JnNZwxoLE7yxzyVkfyy2Q0vdrUno
         Hr0SA6ayuSkY3WeZeZJ0ObJVStHb5X26fdgYfCbW3nypqGRQ3TkGyUA98ocZ5X4rHw3C
         yGdaAP/AOhUWvFV+SiqVAioXrzZ+8k/SV9r6Qxk9v7iCoLmw66lNnXqRltJQyCHSV9Gq
         DxEE8aup7AseBJU/yPOPOraauw12qeJCqtTPIGQKaNJ3TGKKp2rDCUrm9nsj3kS7iq0A
         A9YA==
X-Gm-Message-State: APjAAAW5dsjnBSj8/7bGBSZsUEFD8yH4N/+mqyKmDgPR52TxUh1/1Net
	HoKo+ZQT9SUmtyOsNTz3zlwfTh4MpsTiBvXsZ+0GGV3UAaWPCGPPkmYY6wr43l2gF+H3DVhlJS8
	XCJb0Fj4DY68V7YOM9iUA
X-Received: by 2002:a5d:484d:: with SMTP id n13mr5658174wrs.420.1579619431916;
        Tue, 21 Jan 2020 07:10:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqxxEyxfwVY/ROHiQo6nFEJMG0NaKySaBG+B/YnTEdUCo5yvn8VFW7mI2ukJg01QncMPDMI9zQ==
X-Received: by 2002:a5d:484d:: with SMTP id n13mr5658133wrs.420.1579619431579;
        Tue, 21 Jan 2020 07:10:31 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b509:fc01:ee8a:ca8a? ([2001:b07:6468:f312:b509:fc01:ee8a:ca8a])
        by smtp.gmail.com with ESMTPSA id h2sm53828069wrv.66.2020.01.21.07.10.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 07:10:31 -0800 (PST)
Subject: Re: [PATCH 00/14] KVM: x86/mmu: Huge page fixes, cleanup, and DAX
To: Barret Rhoden <brho@google.com>,
 Sean Christopherson <sean.j.christopherson@intel.com>
References: <20200108202448.9669-1-sean.j.christopherson@intel.com>
 <e3e12d17-32e4-84ad-94da-91095d999238@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d7d0801b-79be-a5e7-a376-abd92b5c09b2@redhat.com>
Date: Tue, 21 Jan 2020 16:10:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <e3e12d17-32e4-84ad-94da-91095d999238@google.com>
Content-Language: en-US
X-MC-Unique: jvgGwqlAPf6QctkMsekoDw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: SFNGJJINQZPSU4VA3EGI5PZNIMWZKHJA
X-Message-ID-Hash: SFNGJJINQZPSU4VA3EGI5PZNIMWZKHJA
X-MailFrom: pbonzini@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Paul Mackerras <paulus@ozlabs.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, Julien Thierry <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, syzbot+c9d1fb51ac9d0d10c39d@syzkaller.appspotmail.com, Andrea Arcangeli <aarcange@redhat.com>, David Hildenbrand <david@redhat.com>, Jason Zeng <jason.zeng@intel.com>, Liran Alon <liran.alon@oracle.com>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SFNGJJINQZPSU4VA3EGI5PZNIMWZKHJA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gMDkvMDEvMjAgMjA6NDcsIEJhcnJldCBSaG9kZW4gd3JvdGU6DQo+IEhpIC0NCj4gDQo+IE9u
IDEvOC8yMCAzOjI0IFBNLCBTZWFuIENocmlzdG9waGVyc29uIHdyb3RlOg0KPj4gVGhpcyBzZXJp
ZXMgaXMgYSBtaXggb2YgYnVnIGZpeGVzLCBjbGVhbnVwIGFuZCBuZXcgc3VwcG9ydCBpbiBLVk0n
cw0KPj4gaGFuZGxpbmcgb2YgaHVnZSBwYWdlcy7CoCBUaGUgc2VyaWVzIGluaXRpYWxseSBzdGVt
bWVkIGZyb20gYSBzeXprYWxsZXINCj4+IGJ1ZyByZXBvcnRbMV0sIHdoaWNoIGlzIGZpeGVkIGJ5
IHBhdGNoIDAyLCAibW06IHRocDogS1ZNOiBFeHBsaWNpdGx5DQo+PiBjaGVjayBmb3IgVEhQIHdo
ZW4gcG9wdWxhdGluZyBzZWNvbmRhcnkgTU1VIi4NCj4+DQo+PiBXaGlsZSBpbnZlc3RpZ2F0aW5n
IG9wdGlvbnMgZm9yIGZpeGluZyB0aGUgc3l6a2FsbGVyIGJ1ZywgSSByZWFsaXplZCBLVk0NCj4+
IGNvdWxkIHJldXNlIHRoZSBhcHByb2FjaCBmcm9tIEJhcnJldCdzIHNlcmllcyB0byBlbmFibGUg
aHVnZSBwYWdlcyBmb3INCj4+IERBWA0KPj4gbWFwcGluZ3MgaW4gS1ZNWzJdIGZvciBhbGwgdHlw
ZXMgb2YgaHVnZSBtYXBwaW5ncywgaS5lLiB3YWxrIHRoZSBob3N0DQo+PiBwYWdlDQo+PiB0YWJs
ZXMgaW5zdGVhZCBvZiBxdWVyeWluZyBtZXRhZGF0YSAocGF0Y2hlcyAwNSAtIDA5KS4NCj4gDQo+
IFRoYW5rcywgU2Vhbi7CoCBJIHRlc3RlZCB0aGlzIHBhdGNoIHNlcmllcyBvdXQsIGFuZCBpdCB3
b3JrcyBmb3IgbWUuDQo+IChIdWdlIEtWTSBtYXBwaW5ncyBvZiBhIERBWCBmaWxlLCBldGMuKS4N
Cg0KUXVldWVkLCB0aGFua3MuDQoNClBhb2xvDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52
ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1u
dmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
