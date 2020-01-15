Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BB913CA0B
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 Jan 2020 17:55:42 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8770310097DC6;
	Wed, 15 Jan 2020 08:58:58 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1EBDE10097DC5
	for <linux-nvdimm@lists.01.org>; Wed, 15 Jan 2020 08:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1579107337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aiHy9sVh9o7u8SSTG9b+BoOWpHEYOVZOoS63pLilv8A=;
	b=LqlB/C5C2/ZewzLO/nG2GNndrKbUGxcIcDB69f2Mu4XhaULjWOFZXI7Vn2S9nvdZZD+E06
	mIWHn9n5n15MBTYEms7dWO5qPpBpCpI/DZwP4rIOAML7yEF+avmibcZKDVDQuw5kT0aK3J
	JW1uXMP/MF0SbgHGW1NIlYpffar4RNs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-Vmp3RQsmNtCNXXfRZsBGsw-1; Wed, 15 Jan 2020 11:55:33 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70C258E0F62;
	Wed, 15 Jan 2020 16:55:32 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0701A811E0;
	Wed, 15 Jan 2020 16:55:31 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [RFC PATCH] libnvdimm: Update the meaning for persistence_domain values
References: <20200108064905.170394-1-aneesh.kumar@linux.ibm.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Wed, 15 Jan 2020 11:55:30 -0500
In-Reply-To: <20200108064905.170394-1-aneesh.kumar@linux.ibm.com> (Aneesh
	Kumar K. V.'s message of "Wed, 8 Jan 2020 12:19:05 +0530")
Message-ID: <x49o8v4oe0t.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Vmp3RQsmNtCNXXfRZsBGsw-1
X-Mimecast-Spam-Score: 0
Message-ID-Hash: DCUWKY2AWYJO5YRRD7RVL7NVRVTOV53E
X-Message-ID-Hash: DCUWKY2AWYJO5YRRD7RVL7NVRVTOV53E
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DCUWKY2AWYJO5YRRD7RVL7NVRVTOV53E/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> Currently, kernel shows the below values
> 	"persistence_domain":"cpu_cache"
> 	"persistence_domain":"memory_controller"
> 	"persistence_domain":"unknown"
>
> This patch updates the meaning of these values such that
>
> "cpu_cache" indicates no extra instructions is needed to ensure the persistence
> of data in the pmem media on power failure.
>
> "memory_controller" indicates platform provided instructions need to be issued
> as per documented sequence to make sure data flushed is guaranteed to be on pmem
> media in case of system power loss.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/papr_scm.c | 7 ++++++-
>  include/linux/libnvdimm.h                 | 6 +++---
>  2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index c2ef320ba1bf..26a5ef263758 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -360,8 +360,13 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>  
>  	if (p->is_volatile)
>  		p->region = nvdimm_volatile_region_create(p->bus, &ndr_desc);
> -	else
> +	else {
> +		/*
> +		 * We need to flush things correctly to guarantee persistance
> +		 */
> +		set_bit(ND_REGION_PERSIST_MEMCTRL, &ndr_desc.flags);
>  		p->region = nvdimm_pmem_region_create(p->bus, &ndr_desc);
> +	}
>  	if (!p->region) {
>  		dev_err(dev, "Error registering region %pR from %pOF\n",
>  				ndr_desc.res, p->dn);

Would you also update of_pmem to indicate the persistence domain,
please?

> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
> index f2a33f2e3ba8..9126737377e1 100644
> --- a/include/linux/libnvdimm.h
> +++ b/include/linux/libnvdimm.h
> @@ -52,9 +52,9 @@ enum {
>  	 */
>  	ND_REGION_PERSIST_CACHE = 1,
>  	/*
> -	 * Platform provides mechanisms to automatically flush outstanding
> -	 * write data from memory controler to pmem on system power loss.
> -	 * (ADR)
> +	 * Platform provides instructions to flush data such that on completion
> +	 * of the instructions, data flushed is guaranteed to be on pmem even
> +	 * in case of a system power loss.

I find the prior description easier to understand.

-Jeff
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
