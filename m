Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B7FA3962
	for <lists+linux-nvdimm@lfdr.de>; Fri, 30 Aug 2019 16:40:18 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 18AEA2021EBF6;
	Fri, 30 Aug 2019 07:42:02 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 74F4920214B20
 for <linux-nvdimm@lists.01.org>; Fri, 30 Aug 2019 07:42:00 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id v5so540058oto.7
 for <linux-nvdimm@lists.01.org>; Fri, 30 Aug 2019 07:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bBkYI9Z4pJQVIRg2Bg7vT4zGigNC/ANgQ2HVLNUrzxY=;
 b=Jp5unDdMDtfyf+c+NrNzR1/84CzMi8rSsidjn/0WGQ0lZLrPov66s9J6WLqYjdfQrE
 9ZHLsmdr5mUotbjFoJXSOlMGL/sdHrDpUIequnZCapdP2TOEKR1TmgpcUb3TPJYMqvd7
 yarbDbcRMCxKmXhjktClizKDZXewsXYdGUyu+4gW7N5OO6B1hwkeL5+jcI96hFNG2n8e
 qPHS+35OVjhhW7TrlBldWmI56dYlDMpzdUjhl+5ZS9pLpqL2ylD1tvIF+zwY4PxeQebs
 JJzYjDR9k2cIPU314jtQ4wq20rcFPhFQj7sHkixip1oBNte6LFGGQxqEDzs/sBzof1UF
 w0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bBkYI9Z4pJQVIRg2Bg7vT4zGigNC/ANgQ2HVLNUrzxY=;
 b=dZiWfUF8jB2p9QUWoH9PLswuzyqUeifMCz22zHCg8lhRcKbTeKXiDlPx5NUwlyWW5g
 GeeoindCdy6MiZXixcHOjHKGXrMwJpFRpLbfNC9QWCIxHcQZ/y6ZVEIRv4nBElEBkksa
 pe2PCQUCRbQwmexXodxtLJfEHmhA0w+YReuK6mqHTJ5cCygOhjKxSiPgOw941tBomVYD
 LLQKxqwrRo/qklqQ7HFXe/W7R5tzUs/3U7BVnkpEt6/iadi3ElTOhbgCW7fxW740R9Eo
 AHvNsOEjfL2NywX3LAgh1ssVXw8AZE6KcuSmsj2M7vJKOZW41BQwOH84a4FgVcor5q2z
 ZUJg==
X-Gm-Message-State: APjAAAVUtOmpifrIAMPcoCeyJJUzQTf+JhYnwC5w2azv85+fgYBcI4SU
 II3nhLuF+qt0hbgeGbUDG2SZxhxqNYVUMF8876++rg==
X-Google-Smtp-Source: APXvYqygzsuhuHQodIv+jqIvbD4JxHgP7Mv1w1lBtuumSwEzdAArruSfKfJ/9Xq2QF1qF9X7yVXFEuef7loIpwyQmPA=
X-Received: by 2002:a05:6830:14d:: with SMTP id
 j13mr4716310otp.71.1567176013761; 
 Fri, 30 Aug 2019 07:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190807040029.11344-1-aneesh.kumar@linux.ibm.com>
 <156711523501.12658.8795324273505326478.git-patchwork-notify@kernel.org>
 <87lfvbnujk.fsf@linux.ibm.com>
 <CAPcyv4g7nQ201DV6r1-2Jq2vyHWzstHD2txwZvR5z6NMY_mqiw@mail.gmail.com>
 <ccf23b5e-4dc8-14c6-31db-cef3bfdf7269@linux.ibm.com>
In-Reply-To: <ccf23b5e-4dc8-14c6-31db-cef3bfdf7269@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 30 Aug 2019 07:40:02 -0700
Message-ID: <CAPcyv4jaz2ZOGSSWov9gHn2FgBpX=RzeQy7_ZpL35tt3MQAANA@mail.gmail.com>
Subject: Re: [PATCH] nvdimm/of_pmem: Provide a unique name for bus provider
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Aug 29, 2019 at 9:45 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 8/30/19 10:10 AM, Dan Williams wrote:
> > On Thu, Aug 29, 2019 at 9:31 PM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> >>
> >> patchwork-bot+linux-nvdimm@kernel.org writes:
> >>
> >>> Hello:
> >>>
> >>> This patch was applied to nvdimm/nvdimm.git (refs/heads/libnvdimm-for-next).
> >>>
> >>> On Wed,  7 Aug 2019 09:30:29 +0530 you wrote:
> >>>> ndctl utility requires the ndbus to have unique names. If not while
> >>>> enumerating the bus in userspace it drops bus with similar names.
> >>>> This results in us not listing devices beneath the bus.
> >>>>
> >>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> >>>> ---
> >>>>   drivers/nvdimm/of_pmem.c | 2 +-
> >>>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>>
> >>> Here is a summary with links:
> >>>    - nvdimm/of_pmem: Provide a unique name for bus provider
> >>>      https://git.kernel.org/nvdimm/nvdimm/c/49bddc73d15c25a68e4294d76fc74519fda984cd
> >>>
> >>> You are awesome, thank you!
> >>
> >> We decided to fix this in ndctl tool? If we go with ndctl fix, we
> >> can drop the kernel change.
> >
> > Oh, I was planning to do both any concerns if I keep the kernel
> > change, otherwise I'll need to rebase the branch.
> >
>
> I guess rebasing is not going to be nice. So we can keep the patch and
> if we are really need to move the provider name to indicate backend
> driver, I will fixup both of_pmem and papr_scm together.

Another reason to make the kernel change is to improve compatibility
with older ndctl releases.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
