Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE418B2383
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Sep 2019 17:37:31 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 73DF7202EA3F1;
	Fri, 13 Sep 2019 08:37:18 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Permerror (SPF Permanent Error: Void lookup limit of 2 exceeded)
 identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=mchehab+samsung@kernel.org; receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id EBA3F202EA3ED
 for <linux-nvdimm@lists.01.org>; Fri, 13 Sep 2019 08:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
 From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C+bQZ7OsAJqgd02njLeMk4sII7e61xhtzjvOa7XtD9U=; b=LkfSSVWwb7TycH4MxAFooZ+0j
 oeUvu5zjwy2Yiys7K395tUgogQVaDKlSwq1AGTdPzzL6TWWbNMUt+kyY8N18KFI1McXNOYJbGhnW0
 0/SGEJVdGCxkKYkqfKqrFMDdPxcgV43kqxfdjznJ5VARwRai2ZYe1Sx3Ev/lZ0odSuK8Z7Q04kdcG
 QEkaYOtAEZmyyMa4h2xzjL0J9IN58sBNihZb9aUgbBVTk6ktsoyYLP4uRe8ejHAk8D4oskKC7UrNN
 8dtpPqur1rOd/G2wlkxT2GsubNaeEb9cOk6WKBr90R/WH+irQPankJzEtRDBueYae9XTqsJXoMXAQ
 yJYL1cscQ==;
Received: from 177.96.232.144.dynamic.adsl.gvt.net.br ([177.96.232.144]
 helo=coco.lan)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i8ndR-0004rG-8P; Fri, 13 Sep 2019 15:37:21 +0000
Date: Fri, 13 Sep 2019 12:37:17 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 1/3] MAINTAINERS: Reclaim the P:
 tag for Maintainer Entry Profile
Message-ID: <20190913123717.31d5b470@coco.lan>
In-Reply-To: <156821692805.2951081.1395288717170089573.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821692805.2951081.1395288717170089573.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Cc: linux-kernel@vger.kernel.org, ksummit-discuss@lists.linuxfoundation.org,
 linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Em Wed, 11 Sep 2019 08:48:48 -0700
Dan Williams <dan.j.williams@intel.com> escreveu:

> Fixup some P: entries to be M: and delete the others that do not include an
> email address. The P: tag will be used to indicate the location of a
> Profile for a given MAINTAINERS entry.
> 
> Cc: Joe Perches <joe@perches.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  MAINTAINERS |   12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 

...

>  MEDIA INPUT INFRASTRUCTURE (V4L/DVB)
>  M:	Mauro Carvalho Chehab <mchehab@kernel.org>
> -P:	LinuxTV.org Project
>  L:	linux-media@vger.kernel.org
>  W:	https://linuxtv.org
>  Q:	http://patchwork.kernel.org/project/linux-media/list/
> @@ -13452,7 +13450,6 @@ S:	Maintained
>  F:	arch/mips/ralink

Acked-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Thanks,
Mauro
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
