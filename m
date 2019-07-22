Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB6F6FCD7
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Jul 2019 11:50:52 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 232A5212BC47D;
	Mon, 22 Jul 2019 02:53:17 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=anshuman.khandual@arm.com; receiver=linux-nvdimm@lists.01.org 
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by ml01.01.org (Postfix) with ESMTP id DAC0D21962301
 for <linux-nvdimm@lists.01.org>; Mon, 22 Jul 2019 02:53:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB82128;
 Mon, 22 Jul 2019 02:50:47 -0700 (PDT)
Received: from [10.162.41.186] (p8cg001049571a15.blr.arm.com [10.162.41.186])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 4C5EB3F694; Mon, 22 Jul 2019 02:50:46 -0700 (PDT)
Subject: Re: [PATCH] memremap: move from kernel/ to mm/
To: Christoph Hellwig <hch@lst.de>, dan.j.williams@intel.com,
 akpm@linux-foundation.org
References: <20190722094143.18387-1-hch@lst.de>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <9cd09b82-ec86-b0c0-79d5-e26ed5ed0b23@arm.com>
Date: Mon, 22 Jul 2019 15:21:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190722094143.18387-1-hch@lst.de>
Content-Language: en-US
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
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>



On 07/22/2019 03:11 PM, Christoph Hellwig wrote:
> memremap.c implements MM functionality for ZONE_DEVICE, so it really
> should be in the mm/ directory, not the kernel/ one.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This always made sense.

FWIW

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
