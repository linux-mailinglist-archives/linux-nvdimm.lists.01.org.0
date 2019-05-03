Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C3213429
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 May 2019 21:52:15 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ADB3721244A76;
	Fri,  3 May 2019 12:52:12 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::744; helo=mail-qk1-x744.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 7D1B42194EB76
 for <linux-nvdimm@lists.01.org>; Fri,  3 May 2019 12:52:11 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w20so4368387qka.7
 for <linux-nvdimm@lists.01.org>; Fri, 03 May 2019 12:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ivgmrdOFqYbX906OA4N9N8K+zP87FPliWqhK06GaWhc=;
 b=Y2+mqpv1ToBfZomGR0KiG0kJTC7Pd0/kQpdMHTLgCyV+gSUCOY8qdd9UCYmiwv8VrP
 a0P2nQSotvfAV+CN79oMGzR3siWxg++Ro/Nh7074im6lvktjpD8hIg0qMeLNeViPAb5p
 Ak6AnFNXIYyOEpaZmHFL4DjYbaTMMsJPHWbtlDryeNYlH9CMipo59Z5bwqt6LnH+866y
 no7ekuTp5m99+xYSlNrDLBL8TWLAbgPMf3WhIiwOO3hmFCWHFVznd4vHpEhYyKrruUob
 /WctC1Yd5I8cShP8X4p/ZyVtrGhsfMRHJnAiQwD7vi7EwWffIOwvaHGiK0CMeMDge/gC
 3dTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ivgmrdOFqYbX906OA4N9N8K+zP87FPliWqhK06GaWhc=;
 b=DqKfxWj0fifPXf2f0dFuXDXpmeWtK8x2S2YI/KZrNhecs0v3o1zlSyw1ERcScMJaZ0
 lfGjnRmjQGYVCjH2vn44c1373dqWvqH78I/VpBsqkEt4Sz16xOzh3oSSPKZFTuFgcB6A
 +kgPf8gKer4OjxoNDtCjfnUGHjnfL19ibbU1k0zHSpaf1CvGxmAHD11XPmF60SoKUU9g
 6X2O+ygLDPuy4fQ84kJqOVX+3VvCVJ0VSLOsT39xtxLGJF/WLr6qntbHcmvL3J6LTANZ
 da7SenDO/CSN+VZHpm6VFhfRelHGwklOaEVmtlUAEgHKW8uvRHsO/2qWPcy+KUVCVuWt
 fHIA==
X-Gm-Message-State: APjAAAUynCH1uAWEKxK29nSyAwG9r7zFbYWwB+akkXAvl89SCZo06O2f
 iygris7q5RWZ3gnHssty8ZUPdw==
X-Google-Smtp-Source: APXvYqwhEb3DduJH9sxXZb04NbmAIe9orgplVqZkdluZyv5W3gUxH6ho/Vp1ktRhA9nOhgZWzjVhcQ==
X-Received: by 2002:a37:b802:: with SMTP id i2mr8702107qkf.343.1556913130058; 
 Fri, 03 May 2019 12:52:10 -0700 (PDT)
Received: from soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net
 ([40.117.208.181])
 by smtp.gmail.com with ESMTPSA id g55sm3082470qtk.76.2019.05.03.12.52.09
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 03 May 2019 12:52:09 -0700 (PDT)
Date: Fri, 3 May 2019 19:52:07 +0000
From: Pavel Tatashin <pasha.tatashin@soleen.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v7 03/12] mm/sparsemem: Add helpers track active portions
 of a section at boot
Message-ID: <20190503195207.l7jrr3z4halukycm@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <155677652226.2336373.8700273400832001094.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155677653785.2336373.11131100812252340469.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <155677653785.2336373.11131100812252340469.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20180716
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
Cc: Michal Hocko <mhocko@suse.com>, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
 Vlastimil Babka <vbabka@suse.cz>, osalvador@suse.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 19-05-01 22:55:37, Dan Williams wrote:
> Prepare for hot{plug,remove} of sub-ranges of a section by tracking a
> section active bitmask, each bit representing 2MB (SECTION_SIZE (128M) /
> map_active bitmask length (64)). If it turns out that 2MB is too large
> of an active tracking granularity it is trivial to increase the size of
> the map_active bitmap.
> 
> The implications of a partially populated section is that pfn_valid()
> needs to go beyond a valid_section() check and read the sub-section
> active ranges from the bitmask.
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Tested-by: Jane Chu <jane.chu@oracle.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Hi Dan,

I have sent comments to the previous version of this patch:
https://lore.kernel.org/lkml/CA+CK2bAfnCVYz956jPTNQ+AqHJs7uY1ZqWfL8fSUFWQOdKxHcg@mail.gmail.com/

I think they still apply to this one.

Thank you,
Pasha
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
