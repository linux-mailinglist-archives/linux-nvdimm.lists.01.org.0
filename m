Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC387217E56
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jul 2020 06:28:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2D4DA110BA96B;
	Tue,  7 Jul 2020 21:28:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::644; helo=mail-ej1-x644.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 236981006183D
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jul 2020 21:27:56 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p20so48882489ejd.13
        for <linux-nvdimm@lists.01.org>; Tue, 07 Jul 2020 21:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8dNw96B96eIbQP472P+15i/r4t0gFAYtc8zARUaecF0=;
        b=NuIWqyjaegQ19QFyhYTJ0y36/0eMyFNfJBL+jmN/1SvmxqjSyG5lJHJdWcy9wXyg4M
         zy7lOCo2bw1cinVxH1l3+0WrbURYr2eYuQNJEMnxBG3T4CgExMU46UqZQixd1aj78OUM
         78/CptqirWWbUEI84ihTiqSnnw6yzzVair+mKB6+l4zzftMrRjKpPkMugswhpdluXKgJ
         aoVSiSO57Cu3iMf+t6CNs56lDskou5ghNPRZMbdiMiQ41mUM5Re5Cw+4/KfHHF7dgIxH
         /pgQXq91bIOxcuCa3VaYk2y7noic6S7FI7vxllIz77rUivHIylJMRIgHQ2C2LMe1MUQQ
         J9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8dNw96B96eIbQP472P+15i/r4t0gFAYtc8zARUaecF0=;
        b=NUTx4ZXo4VTYO/UaA4B8AxMwRbiWNw0p/D76PWZu5D+PiLCprVTCCANYVU3Hv5ybkT
         rhjd/fiWY5T8gugM8XBScgFeiMvOSlFt7Vx5bcej45SPp4G9fLrR9vsuxzPD5taQ8Ues
         QZEF1/lWY03k5PyQQKc4iXyHUok/+L2EZyhAyp+yPHBWJMyGrkadj0TORkTQLFOvm3ti
         BvfcXHSj/MYrz7y4BNYCZedl9D9geKnWozD/MegtIiPdTG6sclqvYJx8+IVgG10DTMRH
         Y60PM8++za0/VNJpau56BqoUavUh7Z1Kd+LdDZtp92cWQVFvvAgBNgWpOI8E57fQSrHU
         pRog==
X-Gm-Message-State: AOAM530nqiBWOF2TngHjC4brri3r6rxTeVyb9MQiEX+tTmmx3py8anK1
	NvIeE8pTGpx/3hPo0Lh9xv3psXlju8Gj1/TIOeD4DA==
X-Google-Smtp-Source: ABdhPJxJ12SOUFRzJMHcuTFgGn9kWF+1e1N3sSWVya5gGxKC/lxUJ29HEPrjNkOM8G1dgLBXhTdyibVCZ2vfYDKLGIg=
X-Received: by 2002:a17:906:da0f:: with SMTP id fi15mr48990019ejb.237.1594182475031;
 Tue, 07 Jul 2020 21:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200707055917.143653-1-justin.he@arm.com> <20200707055917.143653-2-justin.he@arm.com>
 <20200707115454.GN5913@dhcp22.suse.cz> <AM6PR08MB406907F9F2B13DA6DC893AD9F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
 <CAPcyv4ipu4qwKhk4pzJ8nZB2sp+=AndahS8eCgUvFvVP6dEkeA@mail.gmail.com> <AM6PR08MB4069D0D1FD8FB31B6A56DDB5F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
In-Reply-To: <AM6PR08MB4069D0D1FD8FB31B6A56DDB5F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 7 Jul 2020 21:27:43 -0700
Message-ID: <CAPcyv4ivyJsyzcbkBWcqBYZMx3VdJF7+VPCNs177DU2rYqtz_A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as EXPORT_SYMBOL_GPL
To: Justin He <Justin.He@arm.com>
Message-ID-Hash: WCC37DY2G7XXASEZ6L6IZMSZLRHT6NLV
X-Message-ID-Hash: WCC37DY2G7XXASEZ6L6IZMSZLRHT6NLV
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Michal Hocko <mhocko@kernel.org>, David Hildenbrand <david@redhat.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WCC37DY2G7XXASEZ6L6IZMSZLRHT6NLV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jul 7, 2020 at 9:08 PM Justin He <Justin.He@arm.com> wrote:
[..]
> > Especially for architectures that use memblock info for numa info
> > (which seems to be everyone except x86) why not implement a generic
> > memory_add_physaddr_to_nid() that does:
> >
> > int memory_add_physaddr_to_nid(u64 addr)
> > {
> >         unsigned long start_pfn, end_pfn, pfn = PHYS_PFN(addr);
> >         int nid;
> >
> >         for_each_online_node(nid) {
> >                 get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
> >                 if (pfn >= start_pfn && pfn <= end_pfn)
> >                         return nid;
> >         }
> >         return NUMA_NO_NODE;
> > }
>
> Thanks for your suggestion,
> Could I wrap the codes and let memory_add_physaddr_to_nid simply invoke
> phys_to_target_node()?

I think it needs to be the reverse. phys_to_target_node() should call
memory_add_physaddr_to_nid() by default, but fall back to searching
reserved memory address ranges in memblock. See phys_to_target_node()
in arch/x86/mm/numa.c. That one uses numa_meminfo instead of memblock,
but the principle is the same i.e. that a target node may not be
represented in memblock.memory, but memblock.reserved. I'm working on
a patch to provide a function similar to get_pfn_range_for_nid() that
operates on reserved memory.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
