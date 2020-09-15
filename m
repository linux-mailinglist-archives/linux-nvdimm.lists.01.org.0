Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF05526A427
	for <lists+linux-nvdimm@lfdr.de>; Tue, 15 Sep 2020 13:30:18 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B571D13D9A809;
	Tue, 15 Sep 2020 04:30:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2401:3900:2:1::2; helo=ozlabs.org; envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN> 
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2740713D9A808
	for <linux-nvdimm@lists.01.org>; Tue, 15 Sep 2020 04:30:13 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4BrLcd2lksz9sVM;
	Tue, 15 Sep 2020 21:30:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
	s=201909; t=1600169409;
	bh=OQ8ZlDy64ei4/T3Jt7Yt/gqzJpjsR9iZH/wbYSEEXi4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Kt+4Q+i+95pHJ2GUXntDEfvXikdxYELoaEDu8K4QLKvBA3NlsKSvdzQ54SUoHIqVg
	 CSXhc9s33UMWUYMFds1IRNb6TZOEq1WxKSn9Kt6XUVzPW8e2Jh8L0abkdt12A8KB3h
	 3T0gtjXya5WbpHRnLCNy5k2ObQjXQNjs40wJCmAQ5fH6AiZifOf2dbeSFnQpTtEQ6z
	 DpZeuwezpM83zT9UOEhX8yJKsrQk7cUW6fFMDJe2h8OZoKzWWh57PC4IJfxHcTSTJH
	 X/QEX9dIzv5JKDq2SB9Px4TF5RbrSlgRfm645iBnBOupNtkjBe5sUFLuVpY+AO5TU9
	 voPe9UbNcG0lg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org
Subject: Re: [PATCH v2] powerpc/papr_scm: Fix warning triggered by perf_stats_show()
In-Reply-To: <20200912081451.66225-1-vaibhav@linux.ibm.com>
References: <20200912081451.66225-1-vaibhav@linux.ibm.com>
Date: Tue, 15 Sep 2020 21:30:08 +1000
Message-ID: <87imcfp9a7.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Message-ID-Hash: 2N4JKG56RD3SAUBFWD3WMMQVGEVBPDJE
X-Message-ID-Hash: 2N4JKG56RD3SAUBFWD3WMMQVGEVBPDJE
X-MailFrom: mpe@ellerman.id.au
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2N4JKG56RD3SAUBFWD3WMMQVGEVBPDJE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Vaibhav Jain <vaibhav@linux.ibm.com> writes:
> A warning is reported by the kernel in case perf_stats_show() returns
> an error code. The warning is of the form below:
>
>  papr_scm ibm,persistent-memory:ibm,pmemory@44100001:
>  	  Failed to query performance stats, Err:-10
>  dev_attr_show: perf_stats_show+0x0/0x1c0 [papr_scm] returned bad count
>  fill_read_buffer: dev_attr_show+0x0/0xb0 returned bad count
>
> On investigation it looks like that the compiler is silently truncating the
> return value of drc_pmem_query_stats() from 'long' to 'int', since the
> variable used to store the return code 'rc' is an 'int'. This
> truncated value is then returned back as a 'ssize_t' back from
> perf_stats_show() to 'dev_attr_show()' which thinks of it as a large
> unsigned number and triggers this warning..
>
> To fix this we update the type of variable 'rc' from 'int' to
> 'ssize_t' that prevents the compiler from truncating the return value
> of drc_pmem_query_stats() and returning correct signed value back from
> perf_stats_show().
>
> Fixes: 2d02bf835e573 ('powerpc/papr_scm: Fetch nvdimm performance
>        stats from PHYP')

Please don't word wrap the Fixes tag it breaks b4.

I've fixed it up this time.

cheers
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
