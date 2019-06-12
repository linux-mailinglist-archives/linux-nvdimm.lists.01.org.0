Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A354310E
	for <lists+linux-nvdimm@lfdr.de>; Wed, 12 Jun 2019 22:41:35 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0FA0921290DE6;
	Wed, 12 Jun 2019 13:41:34 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Permerror (SPF Permanent Error: Void lookup limit of 2 exceeded)
 identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=mchehab+samsung@kernel.org; receiver=linux-nvdimm@lists.01.org 
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id DB8AE21290DD2
 for <linux-nvdimm@lists.01.org>; Wed, 12 Jun 2019 13:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sI6gwiLkCC9ffzJ87+8NB0VxnCIPAyu/GIglnrwK0WM=; b=FP23l7y8EJ6iZDJ5fph+HSAolj
 trkiU2x7HtkKhSRGUZyZpIiKm15P0rgkbNNalIYFxFuCbDnfS1nokePZq2tTbs0fffUHrAyc3pS+c
 6o69mFfbo/DUz7YUDpimkjmKqFyr8Cd2tsfMOpfUpoxfIs2MqRpLJfuqIZBBmbVG+qgXyMdl1pOCI
 s52wsFUQmJgnSQx78VVQVkbTICGtkN6hXgve34sWqdCW9wf+50/KBu4GnF+R64MbP7IgjDdH6VwYb
 G65VlIyRP2OqJGEUC3TzQ7egPskq0AdIUUTA+VAKbvKJQIMbBN7/rvv12Cwe+T9KDmOVLIxesunR1
 cd20LcJQ==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251]
 helo=coco.lan)
 by casper.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hbA3f-00072C-TH; Wed, 12 Jun 2019 20:41:24 +0000
Date: Wed, 12 Jun 2019 17:41:19 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v1 29/31] docs: nvdimm: convert to ReST
Message-ID: <20190612174119.7c0d94bd@coco.lan>
In-Reply-To: <CAPcyv4g08r6bK_SyTjzKFRM7=wpTQLdmHqRSGh7r-e9YD4tq5Q@mail.gmail.com>
References: <cover.1560364493.git.mchehab+samsung@kernel.org>
 <075d5879142ff1b7ad16f5eccf4759d35ca02fd4.1560364494.git.mchehab+samsung@kernel.org>
 <CAPcyv4g08r6bK_SyTjzKFRM7=wpTQLdmHqRSGh7r-e9YD4tq5Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
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
Cc: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mauro Carvalho Chehab <mchehab@infradead.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Em Wed, 12 Jun 2019 12:04:12 -0700
Dan Williams <dan.j.williams@intel.com> escreveu:

> Hi Mauro,
> 
> On Wed, Jun 12, 2019 at 11:38 AM Mauro Carvalho Chehab
> <mchehab+samsung@kernel.org> wrote:
> >
> > Rename the mtd documentation files to ReST, add an  
> 
> s/mtd/nvdimm/

Sorry, cut and paste issue :-)

> 
> > index for them and adjust in order to produce a nice html
> > output via the Sphinx build system.
> >
> > At its new index.rst, let's add a :orphan: while this is not linked to
> > the main index.rst file, in order to avoid build warnings.  
> 
> Looks ok, but I was not able to apply this one in isolation to give it
> a try. Am I missing some pre-reqs compared to v5.2-rc4?

I wrote the patch before v5.2-rc1, but, as this series touches a lot
of stuff, it was rebased against today's linux-next (next-20190612).

I didn't notice an conflict on this specific file during the rebases
though. 

There is a simple patch applied on linux-next after v5.2-rc4:

commit 3d9cf48b2ca257f1a249b347236098c3cf9d54f1
Author: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Date:   Thu May 9 15:40:49 2019 +0800

    Documentation: nvdimm: Fix typo
    
    Remove the extra 'we '.
    
    Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
    Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Could this be the cause of the issue you're noticing when
trying to apply it?

As this is signed-off by Jon, I suspect it went via docs-next.

Thanks,
Mauro
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
