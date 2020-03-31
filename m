Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E3B19A1BB
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 Apr 2020 00:15:19 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9060510FC3BAA;
	Tue, 31 Mar 2020 15:16:07 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5CBE810FC38BB
	for <linux-nvdimm@lists.01.org>; Tue, 31 Mar 2020 15:16:05 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id v1so27215822edq.8
        for <linux-nvdimm@lists.01.org>; Tue, 31 Mar 2020 15:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gDG5K3foodcrB2fTzHDEt7hcKp+FJf++x/0/NKfoypE=;
        b=HTxJakAW5mPQ9Mu1cF5V0IGLTh/eoClDcTNbPyiOo5Uly0K3mHF9hOj5+8M1lqjzzM
         Q2GIdyy99ntGBpl0ZZQkoZtwYxgKgGZyuyOzintkodPAC6R+he0aMPy6mOt5iIWhPTQ3
         z0iMY9hPdUVhROh01+3JqWFBEbzCNnUz8xTlWcX1NgXCdxDZiWnAUxJJSIjXHg67Pt/q
         pQXQi6yx35zRPa5koGJwVkqP3hvtUfnHl3Dbaa0Xf04by+4IfiJVD8SAi9RF/h8tla6O
         2buDGlXcaUv4X5XnGOPnI5A6tXMBfv3eMSP6LYXb5+h2/8zdBnxIndnBJRURLdJ18gd5
         lwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gDG5K3foodcrB2fTzHDEt7hcKp+FJf++x/0/NKfoypE=;
        b=ge8uTPN5X9D40UInSamnGa+MIR/3unSmkPFmVa2EPlFsDl0f3HAXz/REimYxZE/i8k
         IlNVVuIuQZdB9lBkftBNk+dv3Zyc9QXU5QfMhFL1e+04kEhTajR5LntcYtSUCnKaIZ0n
         hzkPoN0oJJkdad1BgGvebeTgaJb5Sv3GEGwKxIMJy6zJc3wcjC4DppdD3t5uS5RYMHSZ
         42oBf4agc9VYpfuEXBm+R2NPNQN1cbgThDSLXbkpLMtH1X/Aow2yGuKJSjXzO1P3UxWc
         mFZOw3Wqe2VzdHGYtAVhPj967Kw8EXraW2mJoxfGVLRduqjnWr0e07WM1bGSHI171DSu
         Vxpw==
X-Gm-Message-State: ANhLgQ2Mj3QZ2vscvc/oB2RnBbf7elEOTJ8Rg2YK9FQPZiPQXOo6+tBH
	47InGkCTij8RVCw7kECBFswyOnksEx/W04JdjkTPmw==
X-Google-Smtp-Source: ADFU+vv4b57drvu5fiAxsm/JYoPY+jvyDvcT0GcCs+2sXjUGS3tJ1PzOj3yJUgT5d0nWcAy8AlrNAeU1rT+roPvowwo=
X-Received: by 2002:a05:6402:b17:: with SMTP id bm23mr18055331edb.165.1585692914165;
 Tue, 31 Mar 2020 15:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200221175459.255556-1-vaibhav@linux.ibm.com>
In-Reply-To: <20200221175459.255556-1-vaibhav@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 31 Mar 2020 15:15:03 -0700
Message-ID: <CAPcyv4gGuUNuqw1X_mNF058Ap2SFu-tmp0NxgkdPvYsLU8O22Q@mail.gmail.com>
Subject: Re: [ndctl PATCH] monitor: Add epoll timeout for forcing a full dimm
 health check
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Message-ID-Hash: INMOGD7FNQHLBOJHJHSVO72OV2RCWFLW
X-Message-ID-Hash: INMOGD7FNQHLBOJHJHSVO72OV2RCWFLW
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/INMOGD7FNQHLBOJHJHSVO72OV2RCWFLW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Feb 21, 2020 at 9:55 AM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>
> This patch adds a new command argument to the 'monitor' command namely
> '--check-interval' that triggers a call to notify_dimm_event() at
> regular intervals forcing a periodic check of dimm smart events.
>
> This behavior is useful for dimms that do not support event notifications
> in case the health status of an nvdimm changes. This is especially
> true in case of PAPR-SCM dimms as the PHYP hyper-visor doesn't provide
> any notifications to the guest kernel on a change in nvdimm health
> status. In such case periodic polling of the is the only way to track
> the health of a nvdimm.
>
> The patch updates monitor_event() adding a timeout value to
> epoll_wait() call. Also to prevent the possibility of a single dimm
> generating enough events thereby preventing check of health status of
> other nvdimms, a 'fullpoll_ts' time-stamp is added to keep track of
> when full health check of all dimms happened. If after epoll_wait()
> returns 'fullpoll_ts' time-stamp indicates last full dimm health check
> happened beyond 'check-interval' seconds then a full dimm health check
> is enforced.
>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
>  Documentation/ndctl/ndctl-monitor.txt |  4 ++++
>  ndctl/monitor.c                       | 31 ++++++++++++++++++++++++---
>  2 files changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/ndctl/ndctl-monitor.txt b/Documentation/ndctl/ndctl-monitor.txt
> index 2239f047266d..14cc59d57157 100644
> --- a/Documentation/ndctl/ndctl-monitor.txt
> +++ b/Documentation/ndctl/ndctl-monitor.txt
> @@ -108,6 +108,10 @@ will not work if "--daemon" is specified.
>  The monitor will attempt to enable the alarm control bits for all
>  specified events.
>
> +-i::
> +--check-interval=::
> +       Force a recheck of dimm health every <n> seconds.

I'd just call this "-p --poll="  to put the monitor into polled mode.

> +
>  -u::
>  --human::
>         Output monitor notification as human friendly json format instead
> diff --git a/ndctl/monitor.c b/ndctl/monitor.c
> index 1755b87a5eeb..b72c5852524e 100644
> --- a/ndctl/monitor.c
> +++ b/ndctl/monitor.c
> @@ -4,6 +4,7 @@
>  #include <stdio.h>
>  #include <json-c/json.h>
>  #include <libgen.h>
> +#include <time.h>
>  #include <dirent.h>
>  #include <util/json.h>
>  #include <util/filter.h>
> @@ -33,6 +34,7 @@ static struct monitor {
>         bool daemon;
>         bool human;
>         bool verbose;
> +       unsigned int poll_timeout;
>         unsigned int event_flags;
>         struct log_ctx ctx;
>  } monitor;
> @@ -322,9 +324,14 @@ static int monitor_event(struct ndctl_ctx *ctx,
>                 struct monitor_filter_arg *mfa)
>  {
>         struct epoll_event ev, *events;
> -       int nfds, epollfd, i, rc = 0;
> +       int nfds, epollfd, i, rc = 0, polltimeout = -1;
>         struct monitor_dimm *mdimm;
>         char buf;
> +       /* last time a full poll happened */
> +       struct timespec fullpoll_ts, ts;
> +
> +       if (monitor.poll_timeout)
> +               polltimeout = monitor.poll_timeout * 1000;
>
>         events = calloc(mfa->num_dimm, sizeof(struct epoll_event));
>         if (!events) {
> @@ -354,14 +361,30 @@ static int monitor_event(struct ndctl_ctx *ctx,
>                 }
>         }
>
> +       clock_gettime(CLOCK_BOOTTIME, &fullpoll_ts);
>         while (1) {
>                 did_fail = 0;
> -               nfds = epoll_wait(epollfd, events, mfa->num_dimm, -1);
> -               if (nfds <= 0 && errno != EINTR) {
> +               nfds = epoll_wait(epollfd, events, mfa->num_dimm, polltimeout);
> +               if (nfds < 0 && errno != EINTR) {
>                         err(&monitor, "epoll_wait error: (%s)\n", strerror(errno));
>                         rc = -errno;
>                         goto out;
>                 }
> +
> +               /* If needed force a full poll of dimm health */
> +               clock_gettime(CLOCK_BOOTTIME, &ts);
> +               if ((fullpoll_ts.tv_sec - ts.tv_sec) > monitor.poll_timeout) {
> +                       nfds = 0;
> +                       dbg(&monitor, "forcing a full poll\n");
> +               }

Why is this hunk above needed? If the DIMMs are firing events then all
of them that fired will get serviced and on any timeout all DIMMs will
get serviced. Why does fullpoll_ts need to be tracked?

> +
> +               /* If we timed out then fill events array with all dimms */
> +               if (nfds == 0) {
> +                       list_for_each(&mfa->dimms, mdimm, list)
> +                               events[nfds++].data.ptr = mdimm;
> +                       fullpoll_ts = ts;
> +               }
> +
>                 for (i = 0; i < nfds; i++) {
>                         mdimm = events[i].data.ptr;
>                         if (util_dimm_event_filter(mdimm, monitor.event_flags)) {
> @@ -570,6 +593,8 @@ int cmd_monitor(int argc, const char **argv, struct ndctl_ctx *ctx)
>                                 "use human friendly output formats"),
>                 OPT_BOOLEAN('v', "verbose", &monitor.verbose,
>                                 "emit extra debug messages to log"),
> +               OPT_UINTEGER('i', "check-interval", &monitor.poll_timeout,
> +                            "force a dimm health recheck every <n> seconds"),

I'd replace "force a dimm health check" with "poll and report status".

The monitor can theoretically also register for region and bus events,
so --poll option just forces the monitor to report the  all recorded
events not necessarily only dimm events.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
