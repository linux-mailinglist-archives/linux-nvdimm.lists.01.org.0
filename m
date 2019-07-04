Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAF15F9FC
	for <lists+linux-nvdimm@lfdr.de>; Thu,  4 Jul 2019 16:24:01 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 645C2212B0817;
	Thu,  4 Jul 2019 07:23:59 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=helo; client-ip=203.11.71.1;
 helo=ozlabs.org; envelope-from=mpe@ellerman.id.au;
 receiver=linux-nvdimm@lists.01.org 
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 00DA8212B0810
 for <linux-nvdimm@lists.01.org>; Thu,  4 Jul 2019 07:23:57 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45fgFg4cF4z9sPB;
 Fri,  5 Jul 2019 00:23:51 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/nvdimm: Add is_ioremap_addr and use that to check
 ioremap address
In-Reply-To: <87r2792jq5.fsf@linux.ibm.com>
References: <20190701134038.14165-1-aneesh.kumar@linux.ibm.com>
 <20190701165152.7a55299eb670b0ca326f24dd@linux-foundation.org>
 <87r2792jq5.fsf@linux.ibm.com>
Date: Fri, 05 Jul 2019 00:23:49 +1000
Message-ID: <87a7dt3mkq.fsf@concordia.ellerman.id.au>
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> Andrew Morton <akpm@linux-foundation.org> writes:
>
>> On Mon,  1 Jul 2019 19:10:38 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
>>
>>> Architectures like powerpc use different address range to map ioremap
>>> and vmalloc range. The memunmap() check used by the nvdimm layer was
>>> wrongly using is_vmalloc_addr() to check for ioremap range which fails for
>>> ppc64. This result in ppc64 not freeing the ioremap mapping. The side effect
>>> of this is an unbind failure during module unload with papr_scm nvdimm driver
>>
>> The patch applies to 5.1.  Does it need a Fixes: and a Cc:stable?
>
> Actually, we want it to be backported to an older kernel possibly one
> that added papr-scm driver, b5beae5e224f ("powerpc/pseries: Add driver
> for PAPR SCM regions"). But that doesn't apply easily. It does apply
> without conflicts to 5.0

Don't worry about where it applies or doesn't, just tag it with the
correct Fixes: and stable versions and then if it doesn't backport
cleanly then we deal with that later.

cheers
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
