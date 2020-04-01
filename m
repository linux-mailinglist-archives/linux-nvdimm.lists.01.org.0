Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F09FD19A4BF
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 Apr 2020 07:36:37 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F0B3910FC3BBE;
	Tue, 31 Mar 2020 22:37:25 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vajain21@vajain21.in.ibm.com.in.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6636810FC3BBC
	for <linux-nvdimm@lists.01.org>; Tue, 31 Mar 2020 22:37:23 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0315XrxH092496
	for <linux-nvdimm@lists.01.org>; Wed, 1 Apr 2020 01:36:33 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 304g85xc0w-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Wed, 01 Apr 2020 01:36:32 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <vajain21@vajain21.in.ibm.com.in.ibm.com>;
	Wed, 1 Apr 2020 06:36:20 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
	by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Wed, 1 Apr 2020 06:36:17 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0315aQBB56295646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2020 05:36:26 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C5F54C04A;
	Wed,  1 Apr 2020 05:36:26 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 093B34C046;
	Wed,  1 Apr 2020 05:36:24 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.79.182.198])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Wed,  1 Apr 2020 05:36:23 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Wed, 01 Apr 2020 11:06:23 +0530
From: Vaibhav Jain <vajain21@vajain21.in.ibm.com.in.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [ndctl PATCH] monitor: Add epoll timeout for forcing a full dimm health check
In-Reply-To: <CAPcyv4gGuUNuqw1X_mNF058Ap2SFu-tmp0NxgkdPvYsLU8O22Q@mail.gmail.com>
References: <20200221175459.255556-1-vaibhav@linux.ibm.com> <CAPcyv4gGuUNuqw1X_mNF058Ap2SFu-tmp0NxgkdPvYsLU8O22Q@mail.gmail.com>
Date: Wed, 01 Apr 2020 11:06:23 +0530
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20040105-0008-0000-0000-000003684499
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040105-0009-0000-0000-00004A89CB82
Message-Id: <87imij3gyw.fsf@vajain21.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_07:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=1 adultscore=0 mlxscore=0
 clxscore=1034 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004010044
Message-ID-Hash: S3CJZPNUUFNZL4IJNDASMOXCJGKBO2JA
X-Message-ID-Hash: S3CJZPNUUFNZL4IJNDASMOXCJGKBO2JA
X-MailFrom: vajain21@vajain21.in.ibm.com.in.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/S3CJZPNUUFNZL4IJNDASMOXCJGKBO2JA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


Thanks for reviewing this patch,

Dan Williams <dan.j.williams@intel.com> writes:

> On Fri, Feb 21, 2020 at 9:55 AM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>>
>> This patch adds a new command argument to the 'monitor' command namely
>> '--check-interval' that triggers a call to notify_dimm_event() at
>> regular intervals forcing a periodic check of dimm smart events.
>>
>> This behavior is useful for dimms that do not support event notifications
>> in case the health status of an nvdimm changes. This is especially
>> true in case of PAPR-SCM dimms as the PHYP hyper-visor doesn't provide
>> any notifications to the guest kernel on a change in nvdimm health
>> status. In such case periodic polling of the is the only way to track
>> the health of a nvdimm.
>>
>> The patch updates monitor_event() adding a timeout value to
>> epoll_wait() call. Also to prevent the possibility of a single dimm
>> generating enough events thereby preventing check of health status of
>> other nvdimms, a 'fullpoll_ts' time-stamp is added to keep track of
>> when full health check of all dimms happened. If after epoll_wait()
>> returns 'fullpoll_ts' time-stamp indicates last full dimm health check
>> happened beyond 'check-interval' seconds then a full dimm health check
>> is enforced.
>>
>> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>> ---
>>  Documentation/ndctl/ndctl-monitor.txt |  4 ++++
>>  ndctl/monitor.c                       | 31 ++++++++++++++++++++++++---
>>  2 files changed, 32 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/ndctl/ndctl-monitor.txt b/Documentation/ndctl/ndctl-monitor.txt
>> index 2239f047266d..14cc59d57157 100644
>> --- a/Documentation/ndctl/ndctl-monitor.txt
>> +++ b/Documentation/ndctl/ndctl-monitor.txt
>> @@ -108,6 +108,10 @@ will not work if "--daemon" is specified.
>>  The monitor will attempt to enable the alarm control bits for all
>>  specified events.
>>
>> +-i::
>> +--check-interval=::
>> +       Force a recheck of dimm health every <n> seconds.
>
> I'd just call this "-p --poll="  to put the monitor into polled mode.
Agree to the suggestion. Will update the flag name in V2. 

>
>> +
>>  -u::
>>  --human::
>>         Output monitor notification as human friendly json format instead
>> diff --git a/ndctl/monitor.c b/ndctl/monitor.c
>> index 1755b87a5eeb..b72c5852524e 100644
>> --- a/ndctl/monitor.c
>> +++ b/ndctl/monitor.c
>> @@ -4,6 +4,7 @@
>>  #include <stdio.h>
>>  #include <json-c/json.h>
>>  #include <libgen.h>
>> +#include <time.h>
>>  #include <dirent.h>
>>  #include <util/json.h>
>>  #include <util/filter.h>
>> @@ -33,6 +34,7 @@ static struct monitor {
>>         bool daemon;
>>         bool human;
>>         bool verbose;
>> +       unsigned int poll_timeout;
>>         unsigned int event_flags;
>>         struct log_ctx ctx;
>>  } monitor;
>> @@ -322,9 +324,14 @@ static int monitor_event(struct ndctl_ctx *ctx,
>>                 struct monitor_filter_arg *mfa)
>>  {
>>         struct epoll_event ev, *events;
>> -       int nfds, epollfd, i, rc = 0;
>> +       int nfds, epollfd, i, rc = 0, polltimeout = -1;
>>         struct monitor_dimm *mdimm;
>>         char buf;
>> +       /* last time a full poll happened */
>> +       struct timespec fullpoll_ts, ts;
>> +
>> +       if (monitor.poll_timeout)
>> +               polltimeout = monitor.poll_timeout * 1000;
>>
>>         events = calloc(mfa->num_dimm, sizeof(struct epoll_event));
>>         if (!events) {
>> @@ -354,14 +361,30 @@ static int monitor_event(struct ndctl_ctx *ctx,
>>                 }
>>         }
>>
>> +       clock_gettime(CLOCK_BOOTTIME, &fullpoll_ts);
>>         while (1) {
>>                 did_fail = 0;
>> -               nfds = epoll_wait(epollfd, events, mfa->num_dimm, -1);
>> -               if (nfds <= 0 && errno != EINTR) {
>> +               nfds = epoll_wait(epollfd, events, mfa->num_dimm, polltimeout);
>> +               if (nfds < 0 && errno != EINTR) {
>>                         err(&monitor, "epoll_wait error: (%s)\n", strerror(errno));
>>                         rc = -errno;
>>                         goto out;
>>                 }
>> +
>> +               /* If needed force a full poll of dimm health */
>> +               clock_gettime(CLOCK_BOOTTIME, &ts);
>> +               if ((fullpoll_ts.tv_sec - ts.tv_sec) > monitor.poll_timeout) {
>> +                       nfds = 0;
>> +                       dbg(&monitor, "forcing a full poll\n");
>> +               }
>
> Why is this hunk above needed? If the DIMMs are firing events then all
> of them that fired will get serviced and on any timeout all DIMMs will
> get serviced. Why does fullpoll_ts need to be tracked?
>
This hunk was added to prevent any dimm thats firing too many events
from starving the poll of events from other dimms.

>> +
>> +               /* If we timed out then fill events array with all dimms */
>> +               if (nfds == 0) {
>> +                       list_for_each(&mfa->dimms, mdimm, list)
>> +                               events[nfds++].data.ptr = mdimm;
>> +                       fullpoll_ts = ts;
>> +               }
>> +
>>                 for (i = 0; i < nfds; i++) {
>>                         mdimm = events[i].data.ptr;
>>                         if (util_dimm_event_filter(mdimm, monitor.event_flags)) {
>> @@ -570,6 +593,8 @@ int cmd_monitor(int argc, const char **argv, struct ndctl_ctx *ctx)
>>                                 "use human friendly output formats"),
>>                 OPT_BOOLEAN('v', "verbose", &monitor.verbose,
>>                                 "emit extra debug messages to log"),
>> +               OPT_UINTEGER('i', "check-interval", &monitor.poll_timeout,
>> +                            "force a dimm health recheck every <n> seconds"),
>
> I'd replace "force a dimm health check" with "poll and report status".
Fair point. Will update the this usage text in v2.
>
> The monitor can theoretically also register for region and bus events,
> so --poll option just forces the monitor to report the  all recorded
> events not necessarily only dimm events.
Agree

-- 
Vaibhav Jain <vaibhav@linux.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
