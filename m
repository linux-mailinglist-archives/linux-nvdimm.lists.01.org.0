Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6D517529D
	for <lists+linux-nvdimm@lfdr.de>; Mon,  2 Mar 2020 05:21:51 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A76B510FC340C;
	Sun,  1 Mar 2020 20:22:41 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vajain21@vajain21.in.ibm.com.in.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3809810FC33EC
	for <linux-nvdimm@lists.01.org>; Sun,  1 Mar 2020 20:22:39 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0224KWJ7111577
	for <linux-nvdimm@lists.01.org>; Sun, 1 Mar 2020 23:21:46 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2yfmyq866w-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Sun, 01 Mar 2020 23:21:46 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <vajain21@vajain21.in.ibm.com.in.ibm.com>;
	Mon, 2 Mar 2020 04:21:44 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
	by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 2 Mar 2020 04:21:42 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0224KhCf49021436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2020 04:20:43 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB94C4C044;
	Mon,  2 Mar 2020 04:21:40 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80EF04C040;
	Mon,  2 Mar 2020 04:21:38 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.109.195.235])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Mon,  2 Mar 2020 04:21:38 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Mon, 02 Mar 2020 09:51:37 +0530
From: Vaibhav Jain <vajain21@vajain21.in.ibm.com.in.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>, Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH] libnvdimm/bus: return the outvar 'cmd_rc' error code in __nd_ioctl()
In-Reply-To: <CAPcyv4hE_FG0YZXJVA1G=CBq8b9e0K54jxk5Sq5UKU-dnWT2Kg@mail.gmail.com>
References: <20200122155304.120733-1-vaibhav@linux.ibm.com> <x49r1yrboh2.fsf@segfault.boston.devel.redhat.com> <CAPcyv4gn1M87AnuzOEorihG1nmCiHDKL0Z4HfLbNbkeOcO3GPw@mail.gmail.com> <CAPcyv4hE_FG0YZXJVA1G=CBq8b9e0K54jxk5Sq5UKU-dnWT2Kg@mail.gmail.com>
Date: Mon, 02 Mar 2020 09:51:37 +0530
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20030204-0008-0000-0000-0000035831D7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030204-0009-0000-0000-00004A795BC6
Message-Id: <87y2sjtmi6.fsf@vajain21.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-01_09:2020-02-28,2020-03-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1034
 priorityscore=1501 mlxlogscore=999 malwarescore=0 impostorscore=0
 suspectscore=1 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003020030
Message-ID-Hash: PKCF3QOIF3K2QZGHJ7QPAL47OH6VREIA
X-Message-ID-Hash: PKCF3QOIF3K2QZGHJ7QPAL47OH6VREIA
X-MailFrom: vajain21@vajain21.in.ibm.com.in.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PKCF3QOIF3K2QZGHJ7QPAL47OH6VREIA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Dan,

Apologies for responding late to this. My response below

Dan Williams <dan.j.williams@intel.com> writes:

> On Tue, Feb 18, 2020 at 1:03 PM Dan Williams <dan.j.williams@intel.com> wrote:
>>
>> On Tue, Feb 18, 2020 at 1:00 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>> >
>> > Vaibhav Jain <vaibhav@linux.ibm.com> writes:
>> >
>> > > Presently the error code returned via out variable 'cmd_rc' from the
>> > > nvdimm-bus controller function is ignored when called from
>> > > __nd_ioctl() and never communicated back to user-space code that called
>> > > an ioctl on dimm/bus.
>> > >
>> > > This minor patch updates __nd_ioctl() to propagate the value of out
>> > > variable 'cmd_rc' back to user-space in case it reports an error.
>> > >
>> > > Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>> > > ---
>> > >  drivers/nvdimm/bus.c | 5 +++++
>> > >  1 file changed, 5 insertions(+)
>> > >
>> > > diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
>> > > index a8b515968569..5b687a27fdf2 100644
>> > > --- a/drivers/nvdimm/bus.c
>> > > +++ b/drivers/nvdimm/bus.c
>> > > @@ -1153,6 +1153,11 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
>> > >       if (rc < 0)
>> > >               goto out_unlock;
>> > >
>> > > +     if (cmd_rc < 0) {
>> > > +             rc = cmd_rc;
>> > > +             goto out_unlock;
>> > > +     }
>> > > +
>> > >       if (!nvdimm && cmd == ND_CMD_CLEAR_ERROR && cmd_rc >= 0) {
>> > >               struct nd_cmd_clear_error *clear_err = buf;
>> >
>> > Looks good to me.
>> >
>> > Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
>>
>> Applied.
>
> Unapplied. This breaks the NVDIMM unit test, and now that I look
> closer you are likely overlooking the fact that cmd_rc is a
> translation of the firmware status, while the ioctl rc is whether the
> command was successfully submitted. If you want the equivalent of
> cmd_rc in userspace you need to translate the firmware status. See
> ndctl_cmd_submit_xlat() in libndctl as an example of how the
> equivalent of cmd_rc is generated from the firmware status.

This seems to be departure from rest of the libndvdimm where a non zero
value of out-var 'cmd_rc' is treated as an error and communicated back to the
caller. 

However I agree to the points you made that semantics for __nd_ioctl()
are different hence 'cmd_rc' need not be treated the same way as others.
I think it will be better if these points are documented as
code-comments in this function to make it more clearer as to why
negative value 'cmd_rd' will be ignored and how userspace can get hold
of it if needed.

-- 
Vaibhav Jain <vaibhav@linux.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
