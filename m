Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A12771139
	for <lists+linux-nvdimm@lfdr.de>; Tue, 23 Jul 2019 07:32:20 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 059E321A07094;
	Mon, 22 Jul 2019 22:34:44 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id DFF5C21A07093
 for <linux-nvdimm@lists.01.org>; Mon, 22 Jul 2019 22:34:42 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 60so3254697otr.7
 for <linux-nvdimm@lists.01.org>; Mon, 22 Jul 2019 22:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rfVOBTkGgWLnADqNb7WUL1YdExalu2RGHdRuN86uruA=;
 b=cCibAOf/Js0bFf/rOoWSrEyv9y1+LYPfRTwhuC16wpTr2xqyeheiY8joolznjwpFlP
 EbgrMxhMTsMUIefhUgH/OmAXMe6s+jzC0XdqdQeOkk1pUiz/pGhkFAjClaN8uIVhXPF3
 jkqht7TWonRqMhxwIj84p7o2qG7aDmnoSj33hNmiZPmSjKmXJivzBSIab1oXHzDJCYGq
 yUXZreSZ42kaDuP8Ikp/IDHhRmJfO+C47QlO7Af9mva8zDj5lJGj3eyQvC+zwjof36U+
 r9aYfq+OT3HnG5wU/ZC/A6jMWzVUD1dWXhrjMRMOkfkASGysOpiw7bpJIXU1mBVC7XJt
 Vcwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rfVOBTkGgWLnADqNb7WUL1YdExalu2RGHdRuN86uruA=;
 b=SbUXo3KdvBopmbzDE7yh/9+MJOQaHSOwSXC61ouq+dn4NF5PEtVqKdTbcmjf0SvkEy
 TlkphFyUrVoc+yDPPJjSsL+6ufkRpdNWZ5lGrVs3YULWEAjwm1sHtqO6pcAONuy56s64
 qZnMNRViRpvriUupMer/yVMZdOdPSqflUQtRmFvpqP2hW8OCH/fQKk9/pb/DPSF5o166
 1cgSio72aqvPSjV771lhXhf5ohdrTKHXnUcWbziV56R1eYrSRTlefcfPkld2n6RgFoQN
 E6euIIQa1qTapGKbJ/Pu+A3EPGsSL9qSV+rYgi3AS8zAelkeyQ3jiRJrQVfNtOs1LHqo
 j7eQ==
X-Gm-Message-State: APjAAAW0Dnewgh4M/acjQpK2FqNYf8B6MufI5O9YQNG3W6VnPO652UFa
 mtB7EY4Nq2SrVM5I2rntwYvh5dWIa3sJpNkJ7y8uPA==
X-Google-Smtp-Source: APXvYqyjt2ypLm0Iyn93tghYH78tRb7uLgwNWDeXJ9GGqsHKMUS9oIUtJUlcsPdUhpTaqHwb8X/qdw/MGcgyJyksvSU=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr21255488otn.247.1563859934961; 
 Mon, 22 Jul 2019 22:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190722094143.18387-1-hch@lst.de>
In-Reply-To: <20190722094143.18387-1-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 22 Jul 2019 22:32:03 -0700
Message-ID: <CAPcyv4j7wPPBbcPDRGn=L8K-HQCZQbM0+HiXJX_F+1Uway+qXA@mail.gmail.com>
Subject: Re: [PATCH] memremap: move from kernel/ to mm/
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
Cc: Linux MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Jul 22, 2019 at 2:42 AM Christoph Hellwig <hch@lst.de> wrote:
>
> memremap.c implements MM functionality for ZONE_DEVICE, so it really
> should be in the mm/ directory, not the kernel/ one.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
