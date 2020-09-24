Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 169B12778E8
	for <lists+linux-nvdimm@lfdr.de>; Thu, 24 Sep 2020 21:02:59 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 366FC1526194A;
	Thu, 24 Sep 2020 12:02:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::642; helo=mail-ej1-x642.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1EBC913C0B44D
	for <linux-nvdimm@lists.01.org>; Thu, 24 Sep 2020 12:02:53 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o8so217766ejb.10
        for <linux-nvdimm@lists.01.org>; Thu, 24 Sep 2020 12:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zwh0H2Di2EjtS2oxRbwDl/g8AzPPtz4bTYVlHB6Q43U=;
        b=PSB3PcPl255zINexLzD5htRXOK8A7IpaIdKXFGiLO32U75F2k9xaAm8mZS7ely1gPq
         yZLW+0hCIn45DdWUyYO8G9jfS8J6+rlp2nsVNrm8+l/5IaMYV707qmr5UQ0dfW8t8mFM
         TGM/ejnQq6OR4f+ghs/rkS7hDoJYuUJW4L657stRoYQr04STf5dpZEl4CMwmFaDzfbER
         EPIt5iCUQqcQiTMaJpgnlFWhAOySGAsfIYSWvKD+cpfQaaZ8pNFsj3lLaMbMZTcQHkyw
         RvAYj9nOfidFYdho2D68Le7t2VZhia2mhnOBKQiCeSv5uNiyhRaV9CGBi+SEG1SSy/ah
         LHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zwh0H2Di2EjtS2oxRbwDl/g8AzPPtz4bTYVlHB6Q43U=;
        b=kerOYwneZ7lzEcoXchUTrKZg/eltGl+kzMh3zvrVNHjjSPJC7B1qGGdR1VzzeOgO1E
         hX6OJhn/Z1X3CLwm46E1Cbt9cHb6AlNJBIT9JrSSkEWKH0nqoNkrERlWW4IJyX4OtFyJ
         Sl7eypZUuRjSx5nomjMRW+ZSO8JyZYkSbcU2XpF+NlysreeiOXEGlPcEAy14QZCwl7qo
         O2WV0o9aANlm5B+f6kD8THpcCPQtNcf6EpTNKk6sUWcXmhWtSeApMhwd3trL92AIIp+4
         QTl36MzODpobfrRdzpemR/BU5LruBl637MdtRddYK2Bbq4JkuziY+Jzq74HBZxOmByI0
         mIyw==
X-Gm-Message-State: AOAM532S/EMoo9tYHKOH2wtCthOcmCalPrAOew0tcZm2j82Fabpm/fYy
	XP94GXRPNG5K5wxJGpMsGMX18Hn68jBqjBnhKBbG1Q==
X-Google-Smtp-Source: ABdhPJyIjxPAbvw6mQwJDfqAdCr+NXbyHb0p0fA9nsaaQoL9Tj0/ldsUQQNqjWQJKZxocvoYQ0aBvveDA8qxbuKZJtY=
X-Received: by 2002:a17:907:4035:: with SMTP id nk5mr79283ejb.418.1600974171842;
 Thu, 24 Sep 2020 12:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200901083326.21264-1-roger.pau@citrix.com> <20200901083326.21264-3-roger.pau@citrix.com>
In-Reply-To: <20200901083326.21264-3-roger.pau@citrix.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 24 Sep 2020 12:02:40 -0700
Message-ID: <CAPcyv4isGqsNXqz7tmVbu3UZMNSpZUphCKUkyBMgWYwv5o6OLw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] memremap: rename MEMORY_DEVICE_DEVDAX to MEMORY_DEVICE_GENERIC
To: Roger Pau Monne <roger.pau@citrix.com>
Message-ID-Hash: GABXEDH6POROAS4RTIOCTYGAE5GMH64Y
X-Message-ID-Hash: GABXEDH6POROAS4RTIOCTYGAE5GMH64Y
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Logan Gunthorpe <logang@deltatee.com>, Juergen Gross <jgross@suse.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, xen-devel <xen-devel@lists.xenproject.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GABXEDH6POROAS4RTIOCTYGAE5GMH64Y/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Sep 1, 2020 at 1:33 AM Roger Pau Monne <roger.pau@citrix.com> wrote:
>
> This is in preparation for the logic behind MEMORY_DEVICE_DEVDAX also
> being used by non DAX devices.
>

FWIW I would not call this MEMORY_DEVICE_GENERIC. This is really
MEMORY_DEVICE_SIMPLE and the kernel-doc can clarify in contrast to the
other MEMORY_DEVICE types this type implies no need for driver or
filesystem notification when a page goes idle.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
