Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C4631874B
	for <lists+linux-nvdimm@lfdr.de>; Thu, 11 Feb 2021 10:49:13 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0C88D100EA901;
	Thu, 11 Feb 2021 01:49:12 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0D628100EAB0D
	for <linux-nvdimm@lists.01.org>; Thu, 11 Feb 2021 01:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1613036947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D4KClAbW7qAjd5KF/8/23pSoF5vXBE09nxYc8TlmEUM=;
	b=Wvdx4T0etpdPbxWRf+PxEFJXyobCquw7Ia8NzvSSWzmUeffoQFWCwdClzG+m2Hkk8SGnwz
	YemrIMC0OdkIuCDMBpWRJZLYEyOEpk0bZYvgjNDOCVi2cH9z7BygdvvfF0ff+TP6/Zp8DF
	XksTP0UZovQLIQrBYO+RF7TlE+rTDvQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-9tsn6XZgPY-p0wHYN_-nmw-1; Thu, 11 Feb 2021 04:49:03 -0500
X-MC-Unique: 9tsn6XZgPY-p0wHYN_-nmw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F49280364D;
	Thu, 11 Feb 2021 09:48:58 +0000 (UTC)
Received: from [10.36.114.52] (ovpn-114-52.ams2.redhat.com [10.36.114.52])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4AE5010016F4;
	Thu, 11 Feb 2021 09:48:49 +0000 (UTC)
To: Michal Hocko <mhocko@suse.com>
References: <20210208084920.2884-1-rppt@kernel.org>
 <20210208084920.2884-8-rppt@kernel.org> <YCEXMgXItY7xMbIS@dhcp22.suse.cz>
 <20210208212605.GX242749@kernel.org> <YCJMDBss8Qhha7g9@dhcp22.suse.cz>
 <20210209090938.GP299309@linux.ibm.com> <YCKLVzBR62+NtvyF@dhcp22.suse.cz>
 <20210211071319.GF242749@kernel.org> <YCTtSrCEvuBug2ap@dhcp22.suse.cz>
 <0d66baec-1898-987b-7eaf-68a015c027ff@redhat.com>
 <YCT6+9YW474IaKrm@dhcp22.suse.cz>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v17 07/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <367808fc-8f5c-10a4-fc0b-a71df616dfce@redhat.com>
Date: Thu, 11 Feb 2021 10:48:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YCT6+9YW474IaKrm@dhcp22.suse.cz>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Message-ID-Hash: VKWTVFK65WLXE43IQSUFOHY5FMKNQVPF
X-Message-ID-Hash: VKWTVFK65WLXE43IQSUFOHY5FMKNQVPF
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Ander
 sen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VKWTVFK65WLXE43IQSUFOHY5FMKNQVPF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

>> Some random thoughts regarding files.
>>
>> What is the page size of secretmem memory? Sometimes we use huge pages,
>> sometimes we fallback to 4k pages. So I assume huge pages in general?
> 
> Unless there is an explicit request for hugetlb I would say the page
> size is not really important like for any other fds. Huge pages can be
> used transparently.

If everything is currently allocated/mapped on PTE granularity, then yes 
I agree. I remember previous versions used to "pool 2MB pages", which 
might have been problematic (thus, my concerns regarding mmap() etc.). 
If that part is now gone, good!

>   
>> What are semantics of MADV()/FALLOCATE() etc on such files?
> 
> I would expect the same semantic as regular shmem (memfd_create) except
> the memory doesn't have _any_ backing storage which makes it
> unevictable. So the reclaim related madv won't work but there shouldn't
> be any real reason why e.g. MADV_DONTNEED, WILLNEED, DONT_FORK and
> others don't work.

Agreed if we don't have hugepage semantics.

>> Is userfaultfd() properly fenced? Or does it even work (doubt)?
>>
>> How does it behave if I mmap(FIXED) something in between?
>> In which granularity can I do that (->page-size?)?
> 
> Again, nothing really exceptional here. This is a mapping like any
> other from address space manipulation POV.

Agreed with the PTE mapping approach.

> 
>> What are other granularity restrictions (->page size)?
>>
>> Don't want to open a big discussion here, just some random thoughts.
>> Maybe it has all been already figured out and most of the answers
>> above are "Fails with -EINVAL".
> 
> I think that the behavior should be really in sync with shmem semantic
> as much as possible. Most operations should simply work with an
> aditional direct map manipulation. There is no real reason to be
> special. Some functionality might be missing, e.g. hugetlb support but
> that has been traditionally added on top of shmem interface so nothing
> really new here.

Agreed!

-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
