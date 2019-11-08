Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB070F3E6B
	for <lists+linux-nvdimm@lfdr.de>; Fri,  8 Nov 2019 04:30:47 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EDE3F100EA622;
	Thu,  7 Nov 2019 19:33:07 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 742EA100EEB95
	for <linux-nvdimm@lists.01.org>; Thu,  7 Nov 2019 19:33:06 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id a14so4044721oid.5
        for <linux-nvdimm@lists.01.org>; Thu, 07 Nov 2019 19:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NtB37+Q8xvWyEYnhovPvzQrhxqS2lBLxSLUijnwj9JI=;
        b=FRfas5SPxBMSC4DVisx8MORabFwIgq5lwySDwgKd1CXjN2fmnInTfTzfd/12Zf4kwd
         7s723mPTXcsbd4eONjrHEs1ExgPXRwpD2so5jW/aA0M1j/Mdd21FWzvKz0NNmR8g45UJ
         TSQvt/gLwuJ6jvkLvIFFG99T33Yk9Cuk+48m9VmhXMIrFyIZ5Bs2VqKW3s5qR18L4Zss
         vtb2BBZfNNSJTS8qKcpJnHqR4TdOcX/rVLqIsKfr3LD0e2zcHemW+nGkBXnGKpTnunJz
         GhcE+cPH7t8F31zni88ZgcGawamvuyZxMQMOgqg9KFlYwMrlRm/u/3PmtnsGgfNQZAV+
         TqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NtB37+Q8xvWyEYnhovPvzQrhxqS2lBLxSLUijnwj9JI=;
        b=p6OvnrFS6syvVf4aLTiEjOQ6EXGU+0VpSUJX844RufsSe5iY/fGJ1yGwVxhvhYVyzQ
         hS2IeB5Nyqc75hjn80ltjTxjrNJpHL23U+25YXKwyGFNUcKlPl7k5ve6chGNFWoZc0iM
         pnMky0bxgseTGrmVd+Bel0fFKOMIXEIOHXShjoXcJ7zXNYgpTzn5Owu5J5RxUoGrpEp/
         jzLuA+2rIOqpgx+l6Z1HZB4aCshnQoBgpibrZ92RO9rinvloos0s/qaRkhhmUBUld33d
         Lz5WkaUOFPpbXdQyiJOhpchTpuQ93/DOsrLf+YeyLGvk1xxVplRSg1cjEB+U6qnJGUmt
         Z/DA==
X-Gm-Message-State: APjAAAV75s/qxXtGkN1Et1egF1gAoH6/5fIUxV/CKULwhFU08kq8BhGX
	rinvUEijtcvIluh3JmmttQ9MMPwPq5cE7ubZN1ji3A==
X-Google-Smtp-Source: APXvYqzkdkYe4VeO2i7N7ZYvtM3Hm00GKsbQ7o4949RHdq20XH0TD40W5eXI5rdUew808QiCN7vktLt6WHrVYh8m+0A=
X-Received: by 2002:aca:3d84:: with SMTP id k126mr6733699oia.70.1573183843511;
 Thu, 07 Nov 2019 19:30:43 -0800 (PST)
MIME-Version: 1.0
References: <20191030041358.14450-1-ruansy.fnst@cn.fujitsu.com> <e33532a2-a9e5-1578-bdd8-a83d4710a151@cn.fujitsu.com>
In-Reply-To: <e33532a2-a9e5-1578-bdd8-a83d4710a151@cn.fujitsu.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 7 Nov 2019 19:30:32 -0800
Message-ID: <CAPcyv4ivOgMNdvWTtpXw2aaR0o7MEQZ=cDiy=_P9qhVb3QVWdQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/7] xfs: reflink & dedupe for fsdax (read/write path).
To: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Message-ID-Hash: E4PJI5OZLHSIS23EKRSQNSRL54KLKIUG
X-Message-ID-Hash: E4PJI5OZLHSIS23EKRSQNSRL54KLKIUG
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-xfs <linux-xfs@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, "Darrick J. Wong" <darrick.wong@oracle.com>, Goldwyn Rodrigues <rgoldwyn@suse.de>, Christoph Hellwig <hch@infradead.org>, david <david@fromorbit.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, gujx@cn.fujitsu.com, qi.fuli@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/E4PJI5OZLHSIS23EKRSQNSRL54KLKIUG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Nov 7, 2019 at 7:11 PM Shiyang Ruan <ruansy.fnst@cn.fujitsu.com> wrote:
>
> Hi Darrick, Dave,
>
> Do you have any comment on this?

Christoph pointed out at ALPSS that this problem has significant
overlap with the shared page-cache for reflink problem. So I think we
need to solve that first and then circle back to dax reflink support.
I'm starting to take a look at that.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
