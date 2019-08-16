Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FC68FB79
	for <lists+linux-nvdimm@lfdr.de>; Fri, 16 Aug 2019 08:54:49 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CADD7202C80B9;
	Thu, 15 Aug 2019 23:56:39 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=batv+66fbed4ec5b4f711ea06+5836+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 132EA202BB9AB
 for <linux-nvdimm@lists.01.org>; Thu, 15 Aug 2019 23:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GereEEuIF570EiKueg45SrscGAcsm53Jmc8D7sejksY=; b=PpvYvAH+KP58nV6izstqduOxt
 6xZbDzbpIZtPEsO9CQjgqucxq7ocLr0SIseaBoGaJY4NFwkG+IubSesgQwLQBlyQE3QsLPmjVLVfY
 GmuBb7lhlEtEosRF0w8bMzrYlcr4QdtE+hmgmB54j6YH/sFwlDhne3pDBbJ/V4GtymNSSSbJVKDdF
 pelq9A1cESIRK5Y7ix33Fs7hOIYdzquVSs7ZiqG/uL2n4RaGVkxFDL4C94ertZYqFI3nEFVCoZA7F
 Y6FcG+haPB/P3GUmrdK2i7hzOmUO2/m5N1zpZf9U/PzEfFf4snYbd23glYY5wlJvTPC7/fEyFlLeX
 t8QFPJsVg==;
Received: from [2001:4bb8:18c:28b5:44f9:d544:957f:32cb] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hyW8D-0008H2-1p; Fri, 16 Aug 2019 06:54:40 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@mellanox.com>
Subject: add a not device managed memremap_pages v2
Date: Fri, 16 Aug 2019 08:54:30 +0200
Message-Id: <20190816065434.2129-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
 Bharata B Rao <bharata@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Hi Dan and Jason,

Bharata has been working on secure page management for kvmppc guests,
and one I thing I noticed is that he had to fake up a struct device
just so that it could be passed to the devm_memremap_pages
instrastructure for device private memory.

This series adds non-device managed versions of the
devm_request_free_mem_region and devm_memremap_pages functions for
his use case.

Changes since v1:
 - don't overload devm_request_free_mem_region
 - export the memremap_pages and munmap_pages as kvmppc can be a module
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
