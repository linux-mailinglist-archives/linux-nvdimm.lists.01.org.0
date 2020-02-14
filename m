Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3757F15F799
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 Feb 2020 21:19:23 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CEE4D10FC3417;
	Fri, 14 Feb 2020 12:22:37 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0EE971003E996
	for <linux-nvdimm@lists.01.org>; Fri, 14 Feb 2020 12:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1581711556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zUUGrdP4j1cXvm1eFGmQNpbG1sQHN9lpbJso5oFN/oI=;
	b=HnGqV5g19YJM30J9IX6I/aKAVAugE3NbDyQgf5vSDr+IxqjNR/sG7eNHw6XfrhOVEEIKoL
	MLh20R0VIfGtdtjt3dhYp0YH8wzsKeq8wrR4hF2FNp+7miVbmaV6a8IuVxkySI59UEoGZh
	Z4ADFfjyvpRx+nUwKbjkyW1i9Uh1J80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-BGeSogtHN2ixrrdRK5EOyg-1; Fri, 14 Feb 2020 15:19:10 -0500
X-MC-Unique: BGeSogtHN2ixrrdRK5EOyg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28490108592A;
	Fri, 14 Feb 2020 20:19:09 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 687605C1D8;
	Fri, 14 Feb 2020 20:19:08 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 4/4] libnvdimm/region: Introduce an 'align' attribute
References: <158155489850.3343782.2687127373754434980.stgit@dwillia2-desk3.amr.corp.intel.com>
	<158155491952.3343782.4541070487858304628.stgit@dwillia2-desk3.amr.corp.intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Fri, 14 Feb 2020 15:19:07 -0500
In-Reply-To: <158155491952.3343782.4541070487858304628.stgit@dwillia2-desk3.amr.corp.intel.com>
	(Dan Williams's message of "Wed, 12 Feb 2020 16:48:39 -0800")
Message-ID: <x495zg8exc4.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Message-ID-Hash: DPGUGDDI7JJQLRKY3A7YEVGIWZLNWUID
X-Message-ID-Hash: DPGUGDDI7JJQLRKY3A7YEVGIWZLNWUID
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DPGUGDDI7JJQLRKY3A7YEVGIWZLNWUID/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

> The align attribute applies an alignment constraint for namespace
> creation in a region. Whereas the 'align' attribute of a namespace
> applied alignment padding via an info block, the 'align' attribute
> applies alignment constraints to the free space allocation.
>
> The default for 'align' is the maximum known memremap_compat_align()
> across all archs (16MiB from PowerPC at time of writing) multiplied by
> the number of interleave ways if there is blk-aliasing. The minimum is
> PAGE_SIZE and allows for the creation of cross-arch incompatible
> namespaces, just as previous kernels allowed, but the expectation is
> cross-arch and mode-independent compatibility by default.
>
> The regression risk with this change is limited to cases that were
> dependent on the ability to create unaligned namespaces, *and* for some
> reason are unable to opt-out of aligned namespaces by writing to
> 'regionX/align'. If such a scenario arises the default can be flipped
> from opt-out to opt-in of compat-aligned namespace creation, but that is
> a last resort. The kernel will otherwise continue to support existing
> defined misaligned namespaces.
>
> Unfortunately this change needs to touch several parts of the
> implementation at once:
>
> - region/available_size: expand busy extents to current align
> - region/max_available_extent: expand busy extents to current align
> - namespace/size: trim free space to current align
>
> ...to keep the free space accounting conforming to the dynamic align
> setting.
>
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Reported-by: Jeff Moyer <jmoyer@redhat.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Link: https://lore.kernel.org/r/158041478371.3889308.14542630147672668068.stgit@dwillia2-desk3.amr.corp.intel.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

This looks good to me.

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
