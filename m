Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 242742F95F8
	for <lists+linux-nvdimm@lfdr.de>; Sun, 17 Jan 2021 23:35:53 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4F10D100EBBA2;
	Sun, 17 Jan 2021 14:35:51 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 42736100EC1D3
	for <linux-nvdimm@lists.01.org>; Sun, 17 Jan 2021 14:35:47 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id b5so4656354ejv.4
        for <linux-nvdimm@lists.01.org>; Sun, 17 Jan 2021 14:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ulnCSQ44YUhN9X9MAQEMcAc8eh88jI5ZhULk5yuUjlY=;
        b=nH6qQH3CSPydxTALD0skXPT4yCLrsSN7lTRp33mztLs5kVypDJKD4NNP92U3YRluSZ
         V+hoAv2K5mVRcBQ5S3eeqQDll9xwE7NEfJAmv4WqMBrWXiERvLx0mWx4l+AXB3Q/2dMg
         Zr7Hg6UBkpaPU34GaYIwFVG+jxpiO9LoUhfmMD5oKP6EkYO1wTjH/J6DDvTMJfMcO/f8
         NnsawZSVh+dT1z7sADQMkyeF3waZCMRoP6LGK4ken2P/hV2gykYfNU9OdBI6XPXsB2tF
         QObiY285JpBicH0RDp2SUsdQ8Y584b9e1XuwY7V44Nfpdc7t8FZ+1MqczgTeDNmHQFwI
         sA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ulnCSQ44YUhN9X9MAQEMcAc8eh88jI5ZhULk5yuUjlY=;
        b=NHlkBIqI3cv25xYjxUjfqxc5PxelSIBOkCvrY3axel8r2Dx6YmkpdzwSp725K5Ja3K
         RhbHe8T/ARZb8X6XFL+LIA00qrZumz/uidoej8Rcr4sJ2z5/a4D7Z52REBXb/gI1JNcJ
         Q3m1MTX7xwoOCaT0AZ/CzTVXFtlDJsCptpEM2dRCCg96TH4p42PbvKwIxhkEZFB1utfw
         OPsazcrYrJZh3UivcTLFwZDW+46kh7cCbvMA0ubsw8FGF2Ot/djshb3f4EKOz4kEZD2/
         XgbC1j82S6zGC+Tcc/Fdu50oUWrhpaLrw48H0LoGv6kYQzYSnw54HDG5lA3obTsR/ySE
         bxlQ==
X-Gm-Message-State: AOAM532ky1y32eAl5X4ssdcoFrNlCwN002IasdFc3kmr1JfVaQ5DxlId
	dGufNQJofU+h8GfipfieXVdPqZHi+DyL3QP6RvCcsw==
X-Google-Smtp-Source: ABdhPJykQ4aN9XzIZG+k5ieNSCq/ExStxGPgoeTqRdHv4EkpXsssxJrXDWF2Ue2urWeIOyT9kmFppL4L52qSdP+zDxY=
X-Received: by 2002:a17:906:e085:: with SMTP id gh5mr951255ejb.418.1610922945887;
 Sun, 17 Jan 2021 14:35:45 -0800 (PST)
MIME-Version: 1.0
References: <161058499000.1840162.702316708443239771.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161058501210.1840162.8108917599181157327.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210117140142.ab91797266e0bef6b7dba9f9@linux-foundation.org>
In-Reply-To: <20210117140142.ab91797266e0bef6b7dba9f9@linux-foundation.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 17 Jan 2021 14:35:36 -0800
Message-ID: <CAPcyv4jGXoMA2=OGa42_SuOiPjHUH2o_1YE5jQxU51PyKn6b2w@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] mm: Fix page reference leak in soft_offline_page()
To: Andrew Morton <akpm@linux-foundation.org>
Message-ID-Hash: F27W3EN6B6E4ZYCIUC4WGNS4DCCOFDGZ
X-Message-ID-Hash: F27W3EN6B6E4ZYCIUC4WGNS4DCCOFDGZ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Naoya Horiguchi <nao.horiguchi@gmail.com>, Michal Hocko <mhocko@kernel.org>, David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>, stable <stable@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/F27W3EN6B6E4ZYCIUC4WGNS4DCCOFDGZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Jan 17, 2021 at 2:01 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 13 Jan 2021 16:43:32 -0800 Dan Williams <dan.j.williams@intel.com> wrote:
>
> > The conversion to move pfn_to_online_page() internal to
> > soft_offline_page() missed that the get_user_pages() reference taken by
> > the madvise() path needs to be dropped when pfn_to_online_page() fails.
> > Note the direct sysfs-path to soft_offline_page() does not perform a
> > get_user_pages() lookup.
> >
> > When soft_offline_page() is handed a pfn_valid() &&
> > !pfn_to_online_page() pfn the kernel hangs at dax-device shutdown due to
> > a leaked reference.
> >
> > Fixes: feec24a6139d ("mm, soft-offline: convert parameter to pfn")
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > Reviewed-by: Oscar Salvador <osalvador@suse.de>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> A cc:stable patch in the middle is awkward.  I'll make this a
> standalone patch for merging into mainline soon (for 5.11) and shall
> turn the rest into a 4-patch series, OK?

Sounds good to me.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
