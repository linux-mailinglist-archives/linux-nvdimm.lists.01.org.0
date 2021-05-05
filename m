Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ACC374BC3
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 May 2021 01:14:34 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 88C16100F227A;
	Wed,  5 May 2021 16:14:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E055F100F2276
	for <linux-nvdimm@lists.01.org>; Wed,  5 May 2021 16:14:28 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u3so5366074eja.12
        for <linux-nvdimm@lists.01.org>; Wed, 05 May 2021 16:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eV0w8etXkFhUUzYjnKSCsVae1IAlaUtWImvJC4NlGv8=;
        b=zwviguEb5zGUn1BT7p2v9caMPA2xjcLYZJjQnrAJ8xrN61l76tEdBzgUkEu6FDLpEq
         RBdNwziQISfYpW0zyJ2c7Iqi0hWkz8C2CohnGLWlm911dNkGvTWOc3eaoPXUQmWhmNfA
         n71wOZB+JRRELeKzTGetBt1+KRkzSUU7UdwUSpz873EIT7k5z9fmE0rQkuiajCD6WauE
         R7dJd0nbRCAi4RHBgSlK4WI3zadwnsxqTCOeLSMr2xUjLhDNi6APdFJyse8Ev09Gza2C
         t1HnArBpotEIcgWdcUvS2uMKeqCZsCJLA1udF83O58LRfjoWiFObJGA63SvQwYFDLM0M
         PRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eV0w8etXkFhUUzYjnKSCsVae1IAlaUtWImvJC4NlGv8=;
        b=JoujOGQq6F8MSnywzdgm21k2Ug8+6V+YP20Elz/0GLFQUd6kb+e27xVJFcCq8pcJsm
         S4/epkXoLTyedgovoo1nwypGIasVkXtn3FXvVHXK7UXXuFfQtlT1nQHijoHMZBMOqECi
         NWS5jRfvqxyJFOU6oHZwUlJddRRclH923l7516xnNt1wk81oBXygtOwOZuI9/pHHXSf4
         Gx48H84q1JLSbM29z6cDNdGRBnQ5EKcGb0NRpGOpKiybYG61AOSq3DJg8+lksD1NnMGr
         7NXIO0wbvzE7yJrmt8ltXrT48/THHEvrHZ1LReibVCOtxwZ43z5LuDgRSnuPyQgiUiNJ
         1sjQ==
X-Gm-Message-State: AOAM531KRp79PtR6Js/qbWzvmg/VNaNDFr5RMwhwugGRabr0IFlf3oz8
	vG0OxdDAynJ4+KX/hmY8gzbeOuaxjeQPPMHZ+KeuUQ==
X-Google-Smtp-Source: ABdhPJx29/y8lXlVkEIpt+TPUO3t7vpEMfxllyYSQmBbSvX+6rl/xmyA7CaXZBpFUuok8cTB+IATuK/HJi+4WzcOIgg=
X-Received: by 2002:a17:906:a20b:: with SMTP id r11mr1132022ejy.323.1620256467414;
 Wed, 05 May 2021 16:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
 <20210325230938.30752-6-joao.m.martins@oracle.com> <CAPcyv4iOh5wS04F=hftcwN1e3DJTg-qUhw8KHR=+wncqJ2KZsg@mail.gmail.com>
 <52195943-3344-ec9b-3c7f-1e6d415c390e@oracle.com>
In-Reply-To: <52195943-3344-ec9b-3c7f-1e6d415c390e@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 5 May 2021 16:14:31 -0700
Message-ID: <CAPcyv4jReFgPABenyQvA34Oif_bFAVZS++O+waoQtg=WsC-9_g@mail.gmail.com>
Subject: Re: [PATCH v1 05/11] mm/sparse-vmemmap: add a pgmap argument to
 section activation
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: L755LXJ3E5EQASW6RK6ADWD5AVWJI6TO
X-Message-ID-Hash: L755LXJ3E5EQASW6RK6ADWD5AVWJI6TO
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/L755LXJ3E5EQASW6RK6ADWD5AVWJI6TO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, May 5, 2021 at 3:38 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>
>
>
> On 5/5/21 11:34 PM, Dan Williams wrote:
> > On Thu, Mar 25, 2021 at 4:10 PM Joao Martins <joao.m.martins@oracle.com> wrote:
> >>
> >> @altmap is stored in a dev_pagemap, but it will be repurposed for
> >> hotplug memory for storing the memmap in the hotplugged memory[*] and
> >> reusing the altmap infrastructure to that end. This is to say that
> >> altmap can't be replaced with a @pgmap as it is going to cover more than
> >> dev_pagemap backend altmaps.
> >
> > I was going to say, just pass the pgmap and lookup the altmap from
> > pgmap, but Oscar added a use case for altmap independent of pgmap. So
> > you might refresh this commit message to clarify why passing pgmap by
> > itself is not sufficient.
> >
> Isn't that what I am doing above with that exact paragraph? I even
> reference his series at the end of commit description :) in [*]

Oh, sorry, it didn't hit me explicitly that you were talking about
Oscar's work I thought you were referring to your own changes in this
set. I see it now... at a minimum the tense needs updating since
Oscar's changes are in the past not the future anymore. If it helps,
the following reads more direct to me: "In support of using compound
pages for devmap mappings, plumb the pgmap down to the
vmemmap_populate* implementation. Note that while altmap is
retrievable from pgmap the memory hotplug codes passes altmap without
pgmap, so both need to be independently plumbed."
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
