Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909AD49179
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Jun 2019 22:37:00 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 259CD21962301;
	Mon, 17 Jun 2019 13:36:59 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5564F2128A631
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 13:36:57 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id j184so7744490oih.1
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 13:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WUuONrlgmwtIZdvsw0S0/4Mq9T1WyA1gy6J4VLXnacI=;
 b=iJnOfDSpsfcRrkO7Z3UmtsU/3SdEZ7eTfjySEwglR4kCk3eP1rlaXEv8n0WSdyQhgA
 KaWNKrnvNbK3Ivdrsdf3WrCRENxklnMUOfkYt77DH4iUmhsBJjRM+eotXHjLnTJ0fpft
 IRATZl7xjDYDdLodZoW7pDj5e/et1XUyWXubUfGW4vRD1RKoqQhNZy2/KBjKy8cusMgh
 2woSBHrnLGC1xQF+N5ZRLi9uSQi5GRNsM2OXCHe8Pv4k1LMuUVnyUieU8WnCi9CQp/zd
 XBqL0kuZ9/hoegyaGxXD87pJJNEmxb5JL0BejjNLkP1oeIbdjPfVsh40yBVMT2gDQuUx
 ng8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WUuONrlgmwtIZdvsw0S0/4Mq9T1WyA1gy6J4VLXnacI=;
 b=awI75eCzzs9eNT93F4XzYXxhaKk0u2DVHggiYFfKDGdK6vcpfI+cbqcUHRRXBZO2jn
 QNSTd9UudRgW2n106lPl1WHCVNcqAYwHHYSUaK7QE7oQ8DU1KhhnTx2edOLy8zuu12ZI
 hCwnuJVfUxh0V45yFKo6bQIR+NYkjjOm7Z4mpWe81azLV3mBEZ9B2Jo93s312OSiQeVi
 QUVqXyp2RnmUWepineYs5IiZJ4ZnouVE15iDvzsOSwpLcJy4OFdEGznoWGIfnV4h/KJm
 VNwS3suqtTSK35FMLETvXBW3Gd5Zf9aQAGtxuBHXxWnArB4J4EKuscHLZSM3mmYtKO4L
 zodQ==
X-Gm-Message-State: APjAAAVeptNRbFQXhPKo8UjuqEQBN/8T4ZXNK6r4TWiIm7FOUKnEibS0
 1H6QLF4NLvztSM2Qk7Cx7hiHmPkpZ9VleCTkdsmM9w==
X-Google-Smtp-Source: APXvYqyP6F9zlBzZPah8lr14kIAj+Xnb/4HPIraAg3Phba4tJ1HESSkAprhGKci8EGOWV3IPPT/MSOptYr7l5lvozUE=
X-Received: by 2002:aca:3006:: with SMTP id w6mr9263oiw.5.1560803816566; Mon,
 17 Jun 2019 13:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190617122733.22432-1-hch@lst.de>
 <20190617122733.22432-8-hch@lst.de>
 <CAPcyv4hbGfOawfafqQ-L1CMr6OMFGmnDtdgLTXrgQuPxYNHA2w@mail.gmail.com>
 <20190617195404.GA20275@lst.de>
In-Reply-To: <20190617195404.GA20275@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 17 Jun 2019 13:36:44 -0700
Message-ID: <CAPcyv4jhhEbLDi82gVw7GLASEtqU=U7Ty67AGwTijmzMqw8X8Q@mail.gmail.com>
Subject: Re: [PATCH 07/25] memremap: validate the pagemap type passed to
 devm_memremap_pages
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>, nouveau@lists.freedesktop.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Linux MM <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>,
 linux-pci@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Jun 17, 2019 at 12:59 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Jun 17, 2019 at 12:02:09PM -0700, Dan Williams wrote:
> > Need a lead in patch that introduces MEMORY_DEVICE_DEVDAX, otherwise:
>
> Or maybe a MEMORY_DEVICE_DEFAULT = 0 shared by fsdax and p2pdma?

I thought about that, but it seems is_pci_p2pdma_page() needs the
distinction between the 2 types.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
