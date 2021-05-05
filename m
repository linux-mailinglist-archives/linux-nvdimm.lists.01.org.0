Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68539374BAE
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 May 2021 01:03:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B3286100F226E;
	Wed,  5 May 2021 16:03:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3B8FD100F226D
	for <linux-nvdimm@lists.01.org>; Wed,  5 May 2021 16:03:33 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id f24so5362312ejc.6
        for <linux-nvdimm@lists.01.org>; Wed, 05 May 2021 16:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/mxPURQrKLZpHCunAXZDURfdLRg8vPCpqP2FXtjQFn8=;
        b=O1l3ozN47zLge+d2ZQ5g43S6Yuwq7uzi2m7Av4dXOsh2hwke1R/8eU0t0X5gIBEo6o
         ElqQgRKkM0Y6RGwIDxhgS/Zy0MFdD7cXkFN4gH/z3L8FVYz12PrSLpWBHF+PBPxdHhH1
         EmjUg4BrW630yKYiPpbjKpaniAd4GUxcsWiWG7kfkSuPH5zrLvPAZucp1FY3XLTzOOLR
         0k9CVi+tsaV19gTNw/Q1oarQGylEDKs26AKxwep1mQmFSodFqqI4PgpabjTAaWnzUcVj
         hqGOFiRWJwnq2vot2/dIM8jXCz2xNffLwf0IJKXxUxL3pUuWDz6KQtei3ks54ikUHu1p
         FPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/mxPURQrKLZpHCunAXZDURfdLRg8vPCpqP2FXtjQFn8=;
        b=A8obGJUCKu2O4ewdM7jo6lb9nQPZyvsMPDVKWXxm8mZxBnf/EVfbiDH/wQiwESqt4c
         9VMYLhUZdQX3YjsqvbfpZfhMbPiMRaQMilSNk2uLd562H8o1Y44aSVA5YLYQVDYf2ARb
         wnrF1u9uZAuHQjkGvtknqu+C+q5ltUrfDN1MiKnGBN5TmslsoKtRi8NG1jpymLnDkA4z
         kz7aSP2po4x6c0tzb6xfPsfg83dPDxsicmQhWKHAAxWrIeGL6LHc4EpEnX6pH8NPCLCQ
         VWhBbLB9QYLDXtQAhBxrYdqTUomYdQw47xU++ViBopAq+GKKR0fIJWVB00mfDhxohA7r
         kmnQ==
X-Gm-Message-State: AOAM531O8sH9cpNHovfQxyTGRNbde5jo64FiH4iOP0Vgp7xqcaHxn2Hx
	I1ekBt/iUjwf446XiSc6fs9d5lPzqrmUXowOPSlInQ==
X-Google-Smtp-Source: ABdhPJzQx3kM1jIzPHmXVA0dwSZfdsyCI0AZMfCah9vWVrgMpmLofyzWSevjdYrQ+QD6XyrBuEr9oCVmVL27S0ao+Q4=
X-Received: by 2002:a17:906:9381:: with SMTP id l1mr1091356ejx.45.1620255812213;
 Wed, 05 May 2021 16:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
 <20210325230938.30752-5-joao.m.martins@oracle.com> <CAPcyv4gs_rHL7FPqyQEb3yT4jrv8Wo_xA2ojKsppoBfmDocq8A@mail.gmail.com>
 <cd1c9849-8660-dbdc-718a-aa4ba5d48c01@oracle.com> <CAPcyv4jG8+S6xJyp=1S2=dpit0Hs2+HgGwpWeRROCRuJnQYAxQ@mail.gmail.com>
 <56a3e271-4ef8-ba02-639e-fd7fe7de7e36@oracle.com>
In-Reply-To: <56a3e271-4ef8-ba02-639e-fd7fe7de7e36@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 5 May 2021 16:03:36 -0700
Message-ID: <CAPcyv4jGgWMoQQnG69UVRt=DW8ii4MLc-vVO2qVLbyCghGu=0Q@mail.gmail.com>
Subject: Re: [PATCH v1 04/11] mm/memremap: add ZONE_DEVICE support for
 compound pages
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: NKYMXY676HDXSQTEWFAMOPPSRMRYSQCU
X-Message-ID-Hash: NKYMXY676HDXSQTEWFAMOPPSRMRYSQCU
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NKYMXY676HDXSQTEWFAMOPPSRMRYSQCU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, May 5, 2021 at 3:36 PM Joao Martins <joao.m.martins@oracle.com> wrote:
[..]
> > Ah yup, my eyes glazed over that. I think this is another place that
> > benefits from a more specific name than "align". "pfns_per_compound"
> > "compound_pfns"?
> >
> We are still describing a page, just not a base page. So perhaps @pfns_per_hpage ?
>
> I am fine with @pfns_per_compound or @compound_pfns as well.

My only concern about hpage is that hpage implies PMD, where compound
is generic across PMD and PUD.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
