Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CD333D69
	for <lists+linux-nvdimm@lfdr.de>; Tue,  4 Jun 2019 05:11:16 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A5B1021283A64;
	Mon,  3 Jun 2019 20:11:14 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=192.55.52.115;
 helo=mga14.intel.com; envelope-from=richardw.yang@linux.intel.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 69D0821A07093
 for <linux-nvdimm@lists.01.org>; Mon,  3 Jun 2019 20:11:12 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Jun 2019 20:11:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,549,1549958400"; d="scan'208";a="181384504"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga002.fm.intel.com with ESMTP; 03 Jun 2019 20:11:08 -0700
Date: Tue, 4 Jun 2019 11:10:41 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH] libnvdimm, namespace: check nsblk->uuid immediately
 after its allocation
Message-ID: <20190604031041.GA27794@richard>
References: <20190116065144.3499-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190116065144.3499-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: zwisler@kernel.org, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Hi, Dan

Do you have some time on this?

On Wed, Jan 16, 2019 at 02:51:44PM +0800, Wei Yang wrote:
>When creating nd_namespace_blk, its uuid is copied from nd_label->uuid.
>In case the memory allocation fails, it goes to the error branch.
>
>This check is better to be done immediately after memory allocation,
>while current implementation does this after assigning claim_class.
>
>This patch moves the check immediately after uuid allocation.
>
>Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>---
> drivers/nvdimm/namespace_devs.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
>index 681af3a8fd62..9471b9ca04f5 100644
>--- a/drivers/nvdimm/namespace_devs.c
>+++ b/drivers/nvdimm/namespace_devs.c
>@@ -2240,11 +2240,11 @@ static struct device *create_namespace_blk(struct nd_region *nd_region,
> 	nsblk->lbasize = __le64_to_cpu(nd_label->lbasize);
> 	nsblk->uuid = kmemdup(nd_label->uuid, NSLABEL_UUID_LEN,
> 			GFP_KERNEL);
>+	if (!nsblk->uuid)
>+		goto blk_err;
> 	if (namespace_label_has(ndd, abstraction_guid))
> 		nsblk->common.claim_class
> 			= to_nvdimm_cclass(&nd_label->abstraction_guid);
>-	if (!nsblk->uuid)
>-		goto blk_err;
> 	memcpy(name, nd_label->name, NSLABEL_NAME_LEN);
> 	if (name[0])
> 		nsblk->alt_name = kmemdup(name, NSLABEL_NAME_LEN,
>-- 
>2.19.1

-- 
Wei Yang
Help you, Help me
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
