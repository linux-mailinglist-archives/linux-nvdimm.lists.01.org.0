Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77645165614
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Feb 2020 05:08:28 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B8B7910FC341C;
	Wed, 19 Feb 2020 20:09:18 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C847B10FC33FB
	for <linux-nvdimm@lists.01.org>; Wed, 19 Feb 2020 20:09:15 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id b18so26247385oie.2
        for <linux-nvdimm@lists.01.org>; Wed, 19 Feb 2020 20:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WmewNsbCXavqT08nlXRpqjEVUqJNc4XA5NnFJhGvPx8=;
        b=JnKl+Re076MVy2rDv+MKByeAF4W9Hb6wgh9svlROldExXUXmS8ytfLpCez9ho22Zr5
         7Hm6Gu5CkkL7FnoNjRjEpHnD/IBL/psU21pqSm5xx2GRyoHYp0ZgEi4Tokm/nmwVbca4
         NEwlQs2gkMPoePYjouoZEdLoEiirMFWQCdfkefoK+XdQfZnKjeH47htbrp3m4/7ti1up
         0je0nq6pjrKkwMLrIgRmvVN6K+28j9nnsvhiPqIruQeEYozxWny8yr/LtFwY6kjtgnEe
         7uahCLkPwypY18JrkJ2HcKvnhYtkQPRuzuZBKfeTdACOAi/jHrAv56khhdcL3BEPzRtZ
         ymLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WmewNsbCXavqT08nlXRpqjEVUqJNc4XA5NnFJhGvPx8=;
        b=Kq00k0cPZSN+bt2wR8K2y3cpmYFZlowAzOad8NprevqM/GJrluGYRkWsev3CBVP2Iw
         fY9SsdVdPoWmVGlStqTBNt/UD8RGz/RB4R+VpMIHu/a24Aafvpqh3HsSAbepIOEpJV+I
         npTGJMT2Kbm/BKUAYayFeb0wdoPe1IK2TYgL2ooa6c3S7DJVztzjITm5V6gKrI4njiNL
         8pQKkQaITHHjsQfUS5b3RJ8rXNZDy974fx5MU6m+V3PEGZFM7P8bicZeEwfksdjU51sK
         8ZnHBVTb1OmwQHWduOInztHHKg6J2THH7XzXd+bOeZbsWB2RtqQ3vhA58FsdDceN+U5D
         XTtA==
X-Gm-Message-State: APjAAAVd3Joxgd/5Ggxs5yNEltDro2jdzVwvrDG/IWcfWT16i0bQJg6f
	URlEIs1kB4IUOIy3GQGTripZyeCiKLqjQDJ4hmQM8g==
X-Google-Smtp-Source: APXvYqzYvHq+FkvVKzcGqvxbPMlRoFRYw0RX+PfMJw0iVVGXrxciNo9FD8Yi1ZE4D2l3+mVe0MnmnnUdUA7Hqt9PyBg=
X-Received: by 2002:a54:4791:: with SMTP id o17mr685023oic.70.1582171702330;
 Wed, 19 Feb 2020 20:08:22 -0800 (PST)
MIME-Version: 1.0
References: <20200113042453.3579711-1-santosh@fossix.org> <87h7zlykwx.fsf@santosiv.in.ibm.com>
In-Reply-To: <87h7zlykwx.fsf@santosiv.in.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 19 Feb 2020 20:08:11 -0800
Message-ID: <CAPcyv4i-7XKxo8HkBLO_NdWdXVT1q2wF88cYLAZUShucQud21A@mail.gmail.com>
Subject: Re: [PATCH v2 ndctl] ndctl/namespace: Fix enable-namespace error for
 seed namespaces
To: Santosh Sivaraj <santosh@fossix.org>
Message-ID-Hash: FPWTF5DDYTAZJCE2JPRKJVOMXGS5JZGG
X-Message-ID-Hash: FPWTF5DDYTAZJCE2JPRKJVOMXGS5JZGG
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FPWTF5DDYTAZJCE2JPRKJVOMXGS5JZGG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 19, 2020 at 7:53 PM Santosh Sivaraj <santosh@fossix.org> wrote:
>
> Santosh Sivaraj <santosh@fossix.org> writes:
>
> > 'ndctl enable-namespace all' tries to enable seed namespaces too, which results
> > in a error like
> >
> > libndctl: ndctl_namespace_enable: namespace1.0: failed to enable
>
> Dan/Vishal,
>
> Will this patch be taken in the next ndctl release?

Thanks for the reminder. I've picked this up.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
