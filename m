Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2249D007
	for <lists+linux-nvdimm@lfdr.de>; Mon, 26 Aug 2019 15:06:14 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5048120214B36;
	Mon, 26 Aug 2019 06:08:30 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=vgoyal@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id DCE0D20212C96
 for <linux-nvdimm@lists.01.org>; Mon, 26 Aug 2019 06:08:28 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BD1C6307CDD1;
 Mon, 26 Aug 2019 13:06:10 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3993C4524;
 Mon, 26 Aug 2019 13:06:08 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id C1B7C22017B; Mon, 26 Aug 2019 09:06:07 -0400 (EDT)
Date: Mon, 26 Aug 2019 09:06:07 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: piaojun <piaojun@huawei.com>
Subject: Re: [Virtio-fs] [PATCH 04/19] virtio: Implement get_shm_region for
 PCI transport
Message-ID: <20190826130607.GB3561@redhat.com>
References: <20190821175720.25901-1-vgoyal@redhat.com>
 <20190821175720.25901-5-vgoyal@redhat.com>
 <5D63392C.3030404@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5D63392C.3030404@huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 26 Aug 2019 13:06:10 +0000 (UTC)
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
Cc: kbuild test robot <lkp@intel.com>, kvm@vger.kernel.org, miklos@szeredi.hu,
 linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
 Sebastien Boeuf <sebastien.boeuf@intel.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Aug 26, 2019 at 09:43:08AM +0800, piaojun wrote:

[..]
> > +static bool vp_get_shm_region(struct virtio_device *vdev,
> > +			      struct virtio_shm_region *region, u8 id)
> > +{
> > +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > +	struct pci_dev *pci_dev = vp_dev->pci_dev;
> > +	u8 bar;
> > +	u64 offset, len;
> > +	phys_addr_t phys_addr;
> > +	size_t bar_len;
> > +	char *bar_name;
> 
> 'char *bar_name' should be cleaned up to avoid compiling warning. And I
> wonder if you mix tab and blankspace for code indent? Or it's just my
> email display problem?

Will get rid of now unused bar_name. 

Generally git flags if there are tab/space issues. I did not see any. So
if you see something, point it out and I will fix it.

Vivek
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
