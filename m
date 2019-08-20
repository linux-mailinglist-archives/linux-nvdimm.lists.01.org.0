Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 932A1953A3
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Aug 2019 03:44:17 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AD2512020D33C;
	Mon, 19 Aug 2019 18:45:38 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6FFCD2020D338
 for <linux-nvdimm@lists.01.org>; Mon, 19 Aug 2019 18:45:36 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id k22so2871856oiw.11
 for <linux-nvdimm@lists.01.org>; Mon, 19 Aug 2019 18:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hiy2qLGFsI5yCOQjtGw2FlRnrKh/058pTpkwHbYjWn4=;
 b=Ez1qSTYyLQaCZn2QMhz67IzLc8/urEfYaskSA3mavaP51YH8ju0nHD9GTDngUpbjbP
 1AiLAnxbvNCGyrPXwBVEu36Q3uaEuDEqiP2VJkxKTCexg2w+ZjewRqlRgykjbOFRlbTH
 2fLPm9B7vaGcBl10TazsQUg322pErV5Xk4X538qIO8M5JcXIZvaCsR4gzqy01slpxyax
 4G8CymZh5RFI/0K2keiFQUFWjyvgpPwfdc90TOWyfBZs4Eyt8GPcrfEYWBqURbl8VN06
 FBPr/5UyLCA35gk26Ovlht9WPFWzb00trqxgpQVrfYqYIqgKxH+fYUvZyy+4n4tgykEC
 7HdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hiy2qLGFsI5yCOQjtGw2FlRnrKh/058pTpkwHbYjWn4=;
 b=tjcIO9gqWMOpNEX6dgdjol/TygkbkTUiN27rH1BTpvM9FBhkMjTfIQq1Hsw9k/NmKp
 t5ja23skpQSnmSTcLohUlzQdmznYLl/ndTekBP43SfR6qu1DzaZ9MselGO2/YVrMnp7M
 LXksoAi4Mt9I0jZpoj5wv02D14SzylTMAGfPXizuG+AXBkhi1vTZorTW1VUE6lDDgvcf
 3dH4reZrKEo1NeuqsOnNFFcW5TybgEda4jRPv1sOo9jbDUZdQY9w46sdTF+XTGMePwUW
 /0BCXLlGfYHEyMdiEpwaY/DaAzTtpiEp3HjaigoADVlQI/vVKnkIi/dFfM6nsZHGx1wH
 zzoA==
X-Gm-Message-State: APjAAAUaGzoiL3hgsl9xQx6KKa2xEhMmoa7u8GkbDZ+JoP+4pNIi/zjH
 vyj8k2sYo2v5U6Z9I5Bz725vOx4G4PRy7JtAyIRZXg==
X-Google-Smtp-Source: APXvYqxaNpMRYLbfGIBxgJOZMZpvJzzYO44wJfPyyGnlz73jF7wI7dbsRvMZy5tGKZb+Q0OELWHnimWe8R9UTMynpps=
X-Received: by 2002:aca:be43:: with SMTP id o64mr15940919oif.149.1566265453559; 
 Mon, 19 Aug 2019 18:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190818090557.17853-1-hch@lst.de>
 <20190818090557.17853-3-hch@lst.de>
In-Reply-To: <20190818090557.17853-3-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 19 Aug 2019 18:44:02 -0700
Message-ID: <CAPcyv4iYytOoX3QMRmvNLbroxD0szrVLauXFjnQMvtQOH3as_w@mail.gmail.com>
Subject: Re: [PATCH 2/4] memremap: remove the dev field in struct dev_pagemap
To: Christoph Hellwig <hch@lst.de>
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Bharata B Rao <bharata@linux.ibm.com>, Linux MM <linux-mm@kvack.org>,
 Jason Gunthorpe <jgg@mellanox.com>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Sun, Aug 18, 2019 at 2:12 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The dev field in struct dev_pagemap is only used to print dev_name in
> two places, which are at best nice to have.  Just remove the field
> and thus the name in those two messages.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Needs the below as well.

/me goes to check if he ever merged the fix to make the unit test
stuff get built by default with COMPILE_TEST [1]. Argh! Nope, didn't
submit it for 5.3-rc1, sorry for the thrash.

You can otherwise add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

[1]: https://lore.kernel.org/lkml/156097224232.1086847.9463861924683372741.stgit@dwillia2-desk3.amr.corp.intel.com/

---

diff --git a/tools/testing/nvdimm/test/iomap.c
b/tools/testing/nvdimm/test/iomap.c
index cd040b5abffe..3f55f2f99112 100644
--- a/tools/testing/nvdimm/test/iomap.c
+++ b/tools/testing/nvdimm/test/iomap.c
@@ -132,7 +132,6 @@ void *__wrap_devm_memremap_pages(struct device
*dev, struct dev_pagemap *pgmap)
        if (!nfit_res)
                return devm_memremap_pages(dev, pgmap);

-       pgmap->dev = dev;
        if (!pgmap->ref) {
                if (pgmap->ops && (pgmap->ops->kill || pgmap->ops->cleanup))
                        return ERR_PTR(-EINVAL);
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
