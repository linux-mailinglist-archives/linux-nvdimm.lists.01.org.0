Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7048915F852
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 Feb 2020 21:59:22 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B924E10FC33F1;
	Fri, 14 Feb 2020 13:02:37 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8FA0810FC339D
	for <linux-nvdimm@lists.01.org>; Fri, 14 Feb 2020 13:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1581713957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=xlGrvI1xaS/R+PG6hF0vkvw8F7V03CIoauMXv5nvLHg=;
	b=MwPOXPqspMVHF3nvjOggH+o338KiNVKPuTbnp0hJnNXSFAznMWXCHkQUmO238IAP9E17dj
	WnukqwIS4qU7FZx4R/SQwRI7OI5dkZy9e4DI4yORCkeFtGdNWxnsbgRfNhXx33ZgHzgU2V
	umalY155zfM3tLm03rWIpDrFUkPjIP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-GvUqMV_VNn-dvokEBCfy1w-1; Fri, 14 Feb 2020 15:59:13 -0500
X-MC-Unique: GvUqMV_VNn-dvokEBCfy1w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F188100550E;
	Fri, 14 Feb 2020 20:59:11 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EA2628AC42;
	Fri, 14 Feb 2020 20:59:09 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 1/4] mm/memremap_pages: Introduce memremap_compat_align()
References: <158155489850.3343782.2687127373754434980.stgit@dwillia2-desk3.amr.corp.intel.com>
	<158155490379.3343782.10305190793306743949.stgit@dwillia2-desk3.amr.corp.intel.com>
	<x498sl677cf.fsf@segfault.boston.devel.redhat.com>
	<CAPcyv4i8xNEsdX=8c2+ehf24U2AFcc-sKmAPS9UoVvm8z0aRng@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Fri, 14 Feb 2020 15:59:08 -0500
Message-ID: <x49k14odgwz.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Message-ID-Hash: 7MHGBSC454PCZJFZQBC3Z7TM3ECTVKGG
X-Message-ID-Hash: 7MHGBSC454PCZJFZQBC3Z7TM3ECTVKGG
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7MHGBSC454PCZJFZQBC3Z7TM3ECTVKGG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

> On Thu, Feb 13, 2020 at 8:58 AM Jeff Moyer <jmoyer@redhat.com> wrote:

>> I have just a couple of questions.
>>
>> First, can you please add a comment above the generic implementation of
>> memremap_compat_align describing its purpose, and why a platform might
>> want to override it?
>
> Sure, how about:
>
> /*
>  * The memremap() and memremap_pages() interfaces are alternately used
>  * to map persistent memory namespaces. These interfaces place different
>  * constraints on the alignment and size of the mapping (namespace).
>  * memremap() can map individual PAGE_SIZE pages. memremap_pages() can
>  * only map subsections (2MB), and at least one architecture (PowerPC)
>  * the minimum mapping granularity of memremap_pages() is 16MB.
>  *
>  * The role of memremap_compat_align() is to communicate the minimum
>  * arch supported alignment of a namespace such that it can freely
>  * switch modes without violating the arch constraint. Namely, do not
>  * allow a namespace to be PAGE_SIZE aligned since that namespace may be
>  * reconfigured into a mode that requires SUBSECTION_SIZE alignment.
>  */

Well, if we modify the x86 variant to be PAGE_SIZE, I think that text
won't work.  How about:

/*
 * memremap_compat_align should return the minimum alignment for
 * mapping memory via memremap() and memremap_pages().  For x86, this
 * is the system PAGE_SIZE.  Other architectures may impose different
 * restrictions, as is seen on powerpc where the minimum alignment is
 * tied to the linear mapping page size.
 *
 * When creating persistent memory namespaces, the alignment is forced
 * to the least common denominator (MEMREMAP_COMPAT_ALIGN_MAX,
 * currently 16MB).  However, older kernels did not enforce this
 * behavior, so we allow mapping namespaces with smaller alignments,
 * so long as the platform supports it.  See nvdimm_namespace_common_probe.
 */

-Jeff
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
